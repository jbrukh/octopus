//
// Copyright (c) 2013 Jake Brukhman/East River Labs. All rights reserved.
//
package main

import (
	"fmt"
	"github.com/jrallison/go-workers"
	"log"
)

// ----------------------------------------------------------------- //
// Constants
// ----------------------------------------------------------------- //

const (
	RedisServer      = "localhost:6379"
	RedisConnections = 30
	ProcessId        = "1"
	ProcessingQueue  = "sentipus-queue"
	Concurrency      = 10
	StatsServerPort  = 8888
)

func main() {
	workers.Configure(map[string]string{
		// location of redis instance
		"server": RedisServer,
		// number of connections to keep open with redis
		"pool": fmt.Sprintf("%s", RedisConnections),
		// unique process id for this instance of workers (for proper recovery of inprogress jobs on crash)
		"process": ProcessId,
	})

	// pull messages from "myqueue" with concurrency of 10
	workers.Process(ProcessingQueue, sentipusWorker, Concurrency)

	// stats will be available at http://localhost:8080/stats
	go workers.StatsServer(StatsServerPort)

	// Blocks until process is told to exit via unix signal
	workers.Run()
}

func sentipusWorker(args *workers.Args) {
	log.Printf("received message: %v", args)
	// algo, err := args.Get("algorithm").String()
	// if err != nil {
	// 	log.Printf("there was an error: %v", err)
	// } else {
	//	fmt.Printf("got algorithm: %s", algo)
	// }
}