import com.ibm.dbb.build.MVSExec



@Field BuildProperties props = BuildProperties.getInstance()

// load the element properties, processor default and overriding properties
populateBuildProperties(buildFile)


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
	sql.dd(new DDStatement().name("SYSUT1").options("trk space(15,15) unit(vio) new"))
	sql.dd(new DDStatement().name("SYSUT2").options("trk space(5,5) unit(vio) new"))
	// werden DB2DCLG dsn  immer vorher vorhanden sein ? oder werden SQL INCLUDEs (DCLGENS) im repository vorhanden sein ?
	sql.dd(new DDStatement().name("SYSLIB").dsn("${props.DB2DCLG}").options("shr"))
	// sql.dd(new DDStatement().name("DBRMLIB").dsn("&&DBRM(${props.C1ELEMENT})").options("cyl space(1,1,1) unit(work) new recfm(F,B) blksize(80)").pass(true)))
	// com.ibm.dbb.build.BuildException: BGZTK0016E An error occurred running BPXWDYN command 'al
	// loc dd(DBRMLIB) dsn(&&DBRM(HELLO10)) cyl space(1,1,1) unit(work) new recfm(F,B) blksize(80)'.
	sql.dd(new DDStatement().name("DBRMLIB").dsn("&&DBRM"("${props.C1ELEMENT}").options("cyl space(1,1,1) unit(work) new recfm(F,B) blksize(80)").pass(true)))
	sql.dd(new DDStatement().name("SYSIN").dsn("&&ELEMOUT").options('shr'))
	sql.dd(new DDStatement().name("SYSCIN").dsn("&&SYSCIN").options('cyl space(5,5) unit(vio) new').pass(true))
}

// 1) dbrmlib temporaere datei als pds mit member
// 2) mit welchem programm kann eine ein member in eine sequentielle datei kopiert werden
// 3) Muss diese Logik verwendet werden oder 
//     IDXTAB=&C1PRGRP(3,2)
//     TABLK2=NNNNYNNNNNNNNNNNNNNNNNNN
//     BTC=&@@TABBTC(&@#IDXTAB,1)
// 4)
//   DB2VERS='VERSION(&C1FOOTPRT(48,16))'
    



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

def populateBuildProperties(String buildFile) {
	def buildFileName = buildFile.toString()
	def String[] entries = buildFileName.split("/")
	def String[] elementandtype = entries[3].split("[.]")
	def String[] envandstage ="${props.env}".split("-")
	props.ENV = envandstage[0]
	props.STG = envandstage[1]
	props.SYS = entries[1]
	props.SUB = entries[2]
	props.TYP = elementandtype[1]
	props."@@CLI"="${props.ENV}".toString().substring(0,1)
	props."@@TYP"="${props.TYP}".toString().substring(3,7)
	def elementProps = "${props.workspace}/${buildFileName}.properties"
	props.load(new File(elementProps))
	def defaultProps = "${props.DBBBuildDir}/processors/${props.processor}.defaults.properties"
	def overridingProps = "${props.workspace}/configuration/${props.ENV}-${props.STG}/${props.SYS}/${props.SUB}/${props.processor}/${props.processor_group}/${props.TYP}.properties"
	props.load(new File(overridingProps))
	props.load(new File(defaultProps))
	props.load(new File(overridingProps))

	if (props.containsKey("@@TABDB2")) {
		boolean success = setPropsFromTabs(props)
		// do somthing if not success ?
	}
}

boolean setPropsFromTabs() {
	try {
	    // processor-group or processor_group ?
		int tabIndex =Integer.parseInt(props.processor-group.substring(2,4)) - 1

		props."@BTC" = props."@@TABBTC".charAt(tabIndex).toString()
		props."@DB2" = props."@@TABDB2".charAt(tabIndex).toString()
		props."@XDL" = props."@@TABXDL".charAt(tabIndex).toString()
		props."@CIC" = props."@@TABCIC".charAt(tabIndex).toString()
		props."@LK2" = props."@@TABLK2".charAt(tabIndex).toString()
	} catch (StringIndexOutOfBoundsException | NumberFormatException ignored) {
	   println("processorGroup: No valid number found at the required position")
	   return false
	}
	return true
}
