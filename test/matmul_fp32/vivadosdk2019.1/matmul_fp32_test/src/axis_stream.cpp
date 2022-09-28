/******************************************************************************
*
* Copyright (C) 2010 - 2019 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/
/*****************************************************************************/
/**
 *
 * @file xaxidma_example_simple_poll.c
 *
 * This file demonstrates how to use the xaxidma driver on the Xilinx AXI
 * DMA core (AXIDMA) to transfer packets in polling mode when the AXI DMA core
 * is configured in simple mode.
 *
 * This code assumes a loopback hardware widget is connected to the AXI DMA
 * core for data packet loopback.
 *
 * To see the debug print, you need a Uart16550 or uartlite in your system,
 * and please set "-DDEBUG" in your compiler options. You need to rebuild your
 * software executable.
 *
 * Make sure that MEMORY_BASE is defined properly as per the HW system. The
 * h/w system built in Area mode has a maximum DDR memory limit of 64MB. In
 * throughput mode, it is 512MB.  These limits are need to ensured for
 * proper operation of this code.
 *
 *
 * <pre>
 * MODIFICATION HISTORY:
 *
 * Ver   Who  Date     Changes
 * ----- ---- -------- -------------------------------------------------------
 * 4.00a rkv  02/22/11 New example created for simple DMA, this example is for
 *       	       simple DMA
 * 5.00a srt  03/06/12 Added Flushing and Invalidation of Caches to fix CRs
 *		       648103, 648701.
 *		       Added V7 DDR Base Address to fix CR 649405.
 * 6.00a srt  03/27/12 Changed API calls to support MCDMA driver.
 * 7.00a srt  06/18/12 API calls are reverted back for backward compatibility.
 * 7.01a srt  11/02/12 Buffer sizes (Tx and Rx) are modified to meet maximum
 *		       DDR memory limit of the h/w system built with Area mode
 * 7.02a srt  03/01/13 Updated DDR base address for IPI designs (CR 703656).
 * 9.1   adk  01/07/16 Updated DDR base address for Ultrascale (CR 799532) and
 *		       removed the defines for S6/V6.
 * 9.3   ms   01/23/17 Modified printf statement in main function to
 *                     ensure that "Successfully ran" and "Failed" strings are
 *                     available in all examples. This is a fix for CR-965028.
 *       ms   04/05/17 Modified Comment lines in functions to
 *                     recognize it as documentation block for doxygen
 *                     generation of examples.
 * 9.9   rsp  01/21/19 Fix use of #elif check in deriving DDR_BASE_ADDR.
 * </pre>
 *
 * ***************************************************************************

 */
/***************************** Include Files *********************************/
#include <stdio.h>
#include <getopt.h>
#include <sys/mman.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <time.h>
#include <sys/time.h>
#include <unistd.h>
#include <math.h>


#include "xaxidma.h"
#include "xparameters.h"
#include "xdebug.h"

#if defined(XPAR_UARTNS550_0_BASEADDR)
#include "xuartns550_l.h"       /* to use uartns550 */
#endif

#include "header.hpp"

/******************** Constant Definitions **********************************/


/*
 * Device hardware build related constants.
 */

#define DMA_DEV_ID		XPAR_AXIDMA_0_DEVICE_ID

#ifdef XPAR_AXI_7SDDR_0_S_AXI_BASEADDR
#define DDR_BASE_ADDR		XPAR_AXI_7SDDR_0_S_AXI_BASEADDR
#elif defined (XPAR_MIG7SERIES_0_BASEADDR)
#define DDR_BASE_ADDR	XPAR_MIG7SERIES_0_BASEADDR
#elif defined (XPAR_MIG_0_BASEADDR)
#define DDR_BASE_ADDR	XPAR_MIG_0_BASEADDR
#elif defined (XPAR_PSU_DDR_0_S_AXI_BASEADDR)
#define DDR_BASE_ADDR	XPAR_PSU_DDR_0_S_AXI_BASEADDR
#endif

#ifndef DDR_BASE_ADDR
#warning CHECK FOR THE VALID DDR ADDRESS IN XPARAMETERS.H, \
		 DEFAULT SET TO 0x01000000
#define MEM_BASE_ADDR		0x01000000
#else
//#define MEM_BASE_ADDR		(DDR_BASE_ADDR + 0x01000000)
#define MEM_BASE_ADDR		(DDR_BASE_ADDR + 0x10000000)
#endif

#define TX_BUFFER_BASE		(MEM_BASE_ADDR + 0x00100000)
#define RX_BUFFER_BASE		(MEM_BASE_ADDR + 0x00300000)
#define RX_BUFFER_HIGH		(MEM_BASE_ADDR + 0x004FFFFF)

//#define PARA_REG_BASE XPAR_PGDSTR_WRAPPER_0_BASEADDR

#define NUMBER_OF_TRANSFERS	1

/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/


T XAxiDma_SimplePollExample(u16 DeviceId, T in_stream[2*SIZE],
		T out_stream[SIZE], T output_ref[OUT_LEN]);
static T CheckData(T output_ref[OUT_LEN], T output[OUT_LEN]);

/************************** Variable Definitions *****************************/
/*
 * Device instance definitions
 */
XAxiDma AxiDma;

#define WriteReg(BaseAddress, RegOffset, Data)          \
		Xil_Out32((UINTPTR)(BaseAddress + RegOffset), (Data))
#define ReadReg(BaseAddress, RegOffset)          \
		Xil_In32((UINTPTR) (BaseAddress + RegOffset))

/*****************************************************************************/
/**
* The entry point for this example. It invokes the example function,
* and reports the execution status.
*
* @param	None.
*
* @return
*		- XST_SUCCESS if example finishes successfully
*		- XST_FAILURE if example fails.
*
* @note		None.
*
******************************************************************************/
int axis_stream(T in_stream[2*SIZE], T out_stream[SIZE], T output_ref[OUT_LEN])
{
	T Status;

	printf("\r\n--- Entering main() --- \r\n");

	/* Run the poll example for simple transfer */
	Status = XAxiDma_SimplePollExample(DMA_DEV_ID, in_stream, out_stream, output_ref);

	if (Status != XST_SUCCESS) {
		printf("XAxiDma_SimplePoll Example Failed\r\n");
		return XST_FAILURE;
	}

	printf("Successfully ran XAxiDma_SimplePoll Example\r\n");

	printf("--- Exiting main() --- \r\n");

	return XST_SUCCESS;

}

#if defined(XPAR_UARTNS550_0_BASEADDR)
/*****************************************************************************/
/*
*
* Uart16550 setup routine, need to set baudrate to 9600, and data bits to 8
*
* @param	None.
*
* @return	None
*
* @note		None.
*
******************************************************************************/
static void Uart550_Setup(void)
{

	/* Set the baudrate to be predictable
	 */
	XUartNs550_SetBaud(XPAR_UARTNS550_0_BASEADDR,
			XPAR_XUARTNS550_CLOCK_HZ, 9600);

	XUartNs550_SetLineControlReg(XPAR_UARTNS550_0_BASEADDR,
			XUN_LCR_8_DATA_BITS);

}
#endif

/*****************************************************************************/
/**
* The example to do the simple transfer through polling. The constant
* NUMBER_OF_TRANSFERS defines how many times a simple transfer is repeated.
*
* @param	DeviceId is the Device Id of the XAxiDma instance
*
* @return
*		- XST_SUCCESS if example finishes successfully
*		- XST_FAILURE if error occurs
*
* @note		None
*
*
******************************************************************************/


T *TxBufferPtr;
T *RxBufferPtr;
void *ReadReg_vaddr;
void *WriteReg_vaddr;
void *TxBufferPtr_vaddr;
void *RxBufferPtr_vaddr;
void *TxBufferPtr_paddr;
void *RxBufferPtr_paddr;
T XAxiDma_SimplePollExample(u16 DeviceId, T input[IN_LEN],
		T output[OUT_LEN], T output_ref[OUT_LEN])
{
	XAxiDma_Config *CfgPtr;
	int Status;
	T Tries = NUMBER_OF_TRANSFERS;
	int Index;


//	TxBufferPtr = (u8 *)TX_BUFFER_BASE ;
//	RxBufferPtr = (u8 *)RX_BUFFER_BASE;
	TxBufferPtr_paddr = (T *) TX_BUFFER_BASE;
	RxBufferPtr_paddr = (T *) RX_BUFFER_BASE;
	T fd = open("/dev/mem", O_RDWR);
	TxBufferPtr_vaddr   = mmap(NULL, IN_LEN*sizeof(T), PROT_READ|PROT_WRITE, MAP_SHARED, fd,
			TX_BUFFER_BASE);
	RxBufferPtr_vaddr = mmap(NULL, OUT_LEN*sizeof(T), PROT_READ|PROT_WRITE, MAP_SHARED, fd,
			RX_BUFFER_BASE);
	TxBufferPtr = (T *) TxBufferPtr_vaddr;
	RxBufferPtr = (T *) RxBufferPtr_vaddr;

	/* Initialize the XAxiDma device.
	 */
	CfgPtr = XAxiDma_LookupConfig(DeviceId);
	if (!CfgPtr) {
		printf("No config found for %d\r\n", DeviceId);
		return XST_FAILURE;
	}
	printf("Found XAxiDma configuration!\n");

	CfgPtr->BaseAddr   = (UINTPTR)mmap(NULL, IN_LEN*sizeof(T),
						PROT_READ|PROT_WRITE, MAP_SHARED, fd,
						CfgPtr->BaseAddr);
	Status = XAxiDma_CfgInitialize(&AxiDma, CfgPtr);
	if (Status != XST_SUCCESS) {
		printf("Initialization failed %d\r\n", Status);
		return XST_FAILURE;
	}else{
		printf("XAxiDma initialization succeed !%d\r\n", Status);
	}

	if(XAxiDma_HasSg(&AxiDma)){
		printf("Device configured as SG mode \r\n");
		return XST_FAILURE;
	}else{
		printf("Device configured as non-SG mode \r\n");
	}

	/* Disable interrupts, we use polling mode
	 */
	XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DEVICE_TO_DMA);
	XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DMA_TO_DEVICE);

	for(Index = 0; Index < IN_LEN; Index ++) {
			TxBufferPtr[Index] = input[Index];
			printf("Input[%d]=%f\n",
					Index, TxBufferPtr[Index]);
	}
	/* Flush the SrcBuffer before the DMA transfer, in case the Data Cache
	 * is enabled
	 */
//	Xil_DCacheFlushRange((UINTPTR)TxBufferPtr, FFT_LEN);
//#ifdef __aarch64__
//	Xil_DCacheFlushRange((UINTPTR)RxBufferPtr, FFT_LEN);
//#endif

	for(Index = 0; Index < Tries; Index ++) {


		Status = XAxiDma_SimpleTransfer(&AxiDma,(UINTPTR) RxBufferPtr_paddr,
					OUT_LEN*sizeof(T), XAXIDMA_DEVICE_TO_DMA);

		if (Status != XST_SUCCESS) {
			return XST_FAILURE;
		}else{
			printf("XAXIDMA_DEVICE_TO_DMA SUCCESS\n");
		}

		Status = XAxiDma_SimpleTransfer(&AxiDma,(UINTPTR) TxBufferPtr_paddr,
					IN_LEN*sizeof(T), XAXIDMA_DMA_TO_DEVICE);

		if (Status != XST_SUCCESS) {
			return XST_FAILURE;
		}else{
			printf("XAXIDMA_DMA_TO_DEVICE SUCCESS\n");
		}

		while (XAxiDma_Busy(&AxiDma,XAXIDMA_DMA_TO_DEVICE)) {
				/* Wait */
			printf("XAXIDMA_DMA_TO_DEVICE busy\n");
			getchar();
		}
		while (XAxiDma_Busy(&AxiDma,XAXIDMA_DEVICE_TO_DMA)) {
				/* Wait */
			printf("XAXIDMA_DEVICE_TO_DMA busy\n");
			getchar();
		}
		while (XAxiDma_Busy(&AxiDma,XAXIDMA_DMA_TO_DEVICE)) {
				/* Wait */
			printf("XAXIDMA_DMA_TO_DEVICE busy\n");
			getchar();
		}
//		while ((XAxiDma_Busy(&AxiDma,XAXIDMA_DEVICE_TO_DMA)) ||
//			(XAxiDma_Busy(&AxiDma,XAXIDMA_DMA_TO_DEVICE))) {
//				/* Wait */
//		}
		printf("%dth Transfer is done\n", Index);

		Status = CheckData(output_ref, output);
		if (Status != XST_SUCCESS) {
			return XST_FAILURE;
		}

	}

	/* Test finishes successfully
	 */
	return XST_SUCCESS;
}




/*****************************************************************************/
/*
*
* This function checks data buffer after the DMA transfer is finished.
*
* @param	None
*
* @return
*		- XST_SUCCESS if validation is successful.
*		- XST_FAILURE otherwise.
*
* @note		None.
*
******************************************************************************/
static T CheckData(T output_ref[OUT_LEN], T output[OUT_LEN])
{
	T *RxPacket;
	int Index = 0;
//	double Value;

	RxPacket = (T *) RxBufferPtr;
//	Value = 0;

	/* Invalidate the DestBuffer before receiving the data, in case the
	 * Data Cache is enabled
	 */
	for(Index = 0; Index < OUT_LEN; Index++) {
		output[Index] = RxPacket[Index];
	}

	for(Index = 0; Index < OUT_LEN; Index++) {
//		if ((RxPacket[Index]-Value)*(RxPacket[Index]-Value)>0.000001) {
//			printf("Data error %d: %d/%d\r\n",
//			Index, (double)RxPacket[Index],
//				(double)Value);
//
//			return XST_FAILURE;
//		}
		printf("output[%d]=%f,\t"
			   "output_ref[%d]=%f\n",
				Index, output[Index],
				Index, output_ref[Index]);
//		Value = (Value + 1);
	}

	return XST_SUCCESS;
}


