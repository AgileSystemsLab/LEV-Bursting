//setBatchMode(true);

//records the unburst cordlengths of an entire fresh or manipulated set of a wing 

WingDirectory = "F:/wings/wing25/recount";
type = getFileList(WingDirectory);
for(typeNum = 0; typeNum<type.length; typeNum++){
	Setup = getFileList(WingDirectory+"/"+type[typeNum]);
	for(SetupNum = 0; SetupNum<Setup.length; SetupNum++){
		frame = getFileList(WingDirectory+"/"+type[typeNum]+Setup[SetupNum]);
		for(frameNum = 0; frameNum<frame.length;frameNum++){
			processfiles(WingDirectory+"/"+type[typeNum]+Setup[SetupNum]+frame[frameNum],frame[frameNum]);
		}
		run("Summarize");
		run("Read and Write Excel", "dataset_label=Table"+Setup[SetupNum]);
		run("Clear Results");
	}
	exit
	
}

function processfiles(filePlace,FileName){
	if(endsWith(filePlace, "02/")){
		open(filePlace+substring(FileName,0,lengthOf(FileName)-1)+".tif");
		setTool("line");
		waitForUser("Set scale");
		run("Set Scale...", "known=1.5 unit=cm");
		waitForUser("Set Cord Measurement");
		run("Measure");
		close();
	}
}