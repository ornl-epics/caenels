#!../../bin/linux-x86_64/CAENels

## You may have to change CAENels to something else
## everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/CAENels.dbd"
CAENels_registerRecordDeviceDriver pdbbase


#Define protocol path
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(CAENELS0520)/protocol/")

drvAsynIPPortConfigure("caenels1","10.112.30.101:10001",0,0,0)
drvAsynIPPortConfigure("caenels2","10.112.30.102:10001",0,0,0)


drvAsynIPPortConfigure("caenels5","10.112.30.105:10001",0,0,0)
drvAsynIPPortConfigure("caenels6","10.112.30.106:10001",0,0,0)
drvAsynIPPortConfigure("caenels7","10.112.30.107:10001",0,0,0)
drvAsynIPPortConfigure("caenels8","10.112.30.108:10001",0,0,0)
drvAsynIPPortConfigure("caenels9","10.112.30.109:10001",0,0,0)

drvAsynIPPortConfigure("caenels11","10.112.30.111:10001",0,0,0)
drvAsynIPPortConfigure("caenels12","10.112.30.112:10001",0,0,0)
drvAsynIPPortConfigure("caenels13","10.112.30.113:10001",0,0,0)
drvAsynIPPortConfigure("caenels14","10.112.30.114:10001",0,0,0)
drvAsynIPPortConfigure("caenels15","10.112.30.115:10001",0,0,0)
drvAsynIPPortConfigure("caenels16","10.112.30.116:10001",0,0,0)
drvAsynIPPortConfigure("caenels17","10.112.30.117:10001",0,0,0)
drvAsynIPPortConfigure("caenels18","10.112.30.118:10001",0,0,0)
drvAsynIPPortConfigure("caenels19","10.112.30.119:10001",0,0,0)



drvAsynIPPortConfigure("caenels23","10.112.30.123:10001",0,0,0)
drvAsynIPPortConfigure("caenels25","10.112.30.125:10001",0,0,0)


## Load record instances
#dbLoadRecords("db/xxx.db","user=piHost")
dbLoadRecords(db/CAENELS.db)

# ASYN_TRACE_ERROR     0x0001
# ASYN_TRACEIO_DEVICE  0x0002
# ASYN_TRACEIO_FILTER  0x0004
# ASYN_TRACEIO_DRIVER  0x0008
# ASYN_TRACE_FLOW      0x0010
# ASYN_TRACE_WARNING   0x0020


# ASYN_TRACEIO_NODATA 0x0000
# ASYN_TRACEIO_ASCII  0x0001
# ASYN_TRACEIO_ESCAPE 0x0002
# ASYN_TRACEIO_HEX    0x0004


###############autosave##################
epicsEnvSet IOCNAME CAENels
epicsEnvSet SAVE_DIR /home/controls/var/$(IOCNAME)

save_restoreSet_Debug(0)

### status-PV prefix, so save_restore can find its status PV's.
save_restoreSet_status_prefix("BL4A:CS:HPLC:")

set_requestfile_path("$(SAVE_DIR)")
set_savefile_path("$(SAVE_DIR)")

save_restoreSet_NumSeqFiles(3)
save_restoreSet_SeqPeriodInSeconds(600)
set_pass0_restoreFile("$(IOCNAME).sav")
set_pass0_restoreFile("$(IOCNAME)_pass0.sav")
set_pass1_restoreFile("$(IOCNAME).sav")
#########################################



cd "${TOP}/iocBoot/${IOC}"
iocInit
dbpf BL15:CAENELS5:COMSeq.SCAN "2 second"

#asynSetTraceMask("caenels1", 0, 0x8)
#asynSetTraceIOMask("caenels1", 0, 0x1)

###########################################
# Create request file and start periodic 'save'
epicsThreadSleep(5)
makeAutosaveFileFromDbInfo("$(SAVE_DIR)/$(IOCNAME).req", "autosaveFields")
makeAutosaveFileFromDbInfo("$(SAVE_DIR)/$(IOCNAME)_pass0.req", "autosaveFields_pass0")
create_monitor_set("$(IOCNAME).req", 5)
create_monitor_set("$(IOCNAME)_pass0.req", 30)



