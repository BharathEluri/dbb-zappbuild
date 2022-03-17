import com.ibm.dbb.build.MVSExec



@Field BuildProperties props = BuildProperties.getInstance()

MVSExec sql = createSqlCommand(buildFile, logicalFile, member, logFile)
MVSExec trn = createTrnCommand(buildFile, logicalFile, member, logFile)
MVSExec compile = createCompileCommand(buildFile, logicalFile, member, logFile)
MVSExec lked1 = createLked1Command(buildFile, logicalFile, member, logFile)
MVSExec lked2 = createLked2Command(buildFile, logicalFile, member, logFile)
MVSExec dbrmcopy = createDbrmcopyCommand(buildFile, logicalFile, member, logFile)

// execute mvs commands in a mvs job
MVSJob job = new MVSJob()
job.start()
if ("${props.COB3DYN}"== "N" && "${props.@DB2}" == "Y") {
	//	sql.execute()
}
job.stop()


def createSqlCommand(buildFile, logicalFile, member, logFile) {

	def sql = new MVSExec().pgm("DSNHPC").parm("${props.DB2OPT}")
	sql.dd(new DDStatement().name("TASKLIB").dsn("${props.DB2EXIT}").options("shr"))
	sql.dd(new DDStatement().dsn("${props.DB2LOAD}").options("shr"))
	sql.dd(new DDStatement().name("SYSPRINT").dsn("&&SQLLIST").options('cyl space(5,5) unit(vio) new').pass(true))
	sql.dd(new DDStatement().name("SYSTERM").options("DUMMY"))
	// können bestehenden trk space options behalten werden ? denn sie geben error.
	// kann cyl mit 1,1 verwendent werden
	//	sql.dd(new DDStatement().name("SYSUT1").options("trk space(15,15) unit(vio) new"))
	//  sql.dd(new DDStatement().name("SYSUT2").options("trk space(5,5) unit(vio) new"))
	//  com.ibm.dbb.build.BuildException: BGZTK0016E An error occurred running BPXWDYN command 'al
	//  loc dd(SYSUT1) trk space(15,15) unit(vio) new'
	//  com.ibm.dbb.build.BuildException: BGZTK0016E An error occurred running BPXWDYN command 'al
	//  loc dd(SYSUT2) trk space(5,5) unit(vio) new'
	//  trk -- cyl 1,1
	sql.dd(new DDStatement().name("SYSUT1").options("cyl space(1,1) unit(vio) new"))
	sql.dd(new DDStatement().name("SYSUT2").options("cyl space(1,1) unit(vio) new"))
	// werden DB2DCLG dsn  immer vorher vorhanden sein ? oder werden SQL INCLUDEs (DCLGENS) im repository vorhanden sein ? 
	// im repository werden vorhanden sein
	sql.dd(new DDStatement().name("SYSLIB").dsn("${props.DB2DCLG}").options("shr"))
	// sql.dd(new DDStatement().name("DBRMLIB").dsn("&&DBRM(${props.C1ELEMENT})").options("cyl space(1,1,1) unit(work) new recfm(F,B) blksize(80)").pass(true)))
	// com.ibm.dbb.build.BuildException: BGZTK0016E An error occurred running BPXWDYN command 'al
	// loc dd(DBRMLIB) dsn(&&DBRM(HELLO10)) cyl space(1,1,1) unit(work) new recfm(F,B) blksize(80)'.
	// feste datei kuenstlichen name,  danach kann feste datei deleted werden 
	sql.dd(new DDStatement().name("DBRMLIB").dsn("${props.dbrmDsn}(${props.C1ELEMENT})").options("shr"))
	//sql.dd(new DDStatement().name("SYSIN").dsn("&&ELEMOUT").options('shr'))
	// statt elemout ist ${props.sysinDsn}(${props.C1ELEMENT}) zu verwenden  
	sql.dd(new DDStatement().name("SYSIN").dsn("${props.sysinDsn}(${props.C1ELEMENT})").options("shr"))	
	sql.dd(new DDStatement().name("SYSCIN").dsn("&&SYSCIN").options('cyl space(5,5) unit(vio) new').pass(true))
	//im JCL ist SYSIN &&ELEMOUT, SYSCIN ist &&SYSCIN
	//im dbb ist SYSIN ${hlq}.COBOL($member) Bespiel SAMPAPP.BUILD.COBOL(XXXX),   SYSCIN ist  &&SYSCIN
	
	//copy von temp datei "&&SYSCIN"  - pds member  - IEBGENER
	  
	// 1) dbrmlib temporaere datei als pds mit member     - feste datei und delete 
	// 2) mit welchem programm kann eine ein member in eine sequentielle datei kopiert werden  - sequentielle datei nach feste datei mit iebgener
	// 3) Muss diese Logik verwendet werden oder (nein) (einzelwerte müssten gelifert werden)
	//     IDXTAB=&C1PRGRP(3,2)
	//     TABLK2=NNNNYNNNNNNNNNNNNNNNNNNN
	//     BTC=&@@TABBTC(&@#IDXTAB,1)
	// 4)
	//   DB2VERS='VERSION(&C1FOOTPRT(48,16))'
	//    VERSION(AUTO) zu verwenden
}


def createTrnCommand(buildFile, logicalFile, member, logFile) {
}

def createCompileCommand(buildFile, logicalFile, member, logFile) {
}

def createLked1Command(buildFile, logicalFile, member, logFile) {
}

def createLked2Command(buildFile, logicalFile, member, logFile) {
}

def createDbrmcopyCommand(buildFile, logicalFile, member, logFile) {
}
