import com.ibm.dbb.build.MVSExec



@Field BuildProperties props = BuildProperties.getInstance()

MVSExec sql = createSqlCommand(buildFile, logicalFile, C1ELEMENT, logFile)
MVSExec trn = createTrnCommand(buildFile, logicalFile, C1ELEMENT, logFile)
MVSExec compile = createCompileCommand(buildFile, logicalFile, C1ELEMENT, logFile)
MVSExec lked1 = createLked1Command(buildFile, logicalFile, C1ELEMENT, logFile)
MVSExec lked2 = createLked2Command(buildFile, logicalFile, C1ELEMENT, logFile)
MVSExec dbrmcopy = createDbrmcopyCommand(buildFile, logicalFile, C1ELEMENT, logFile)

// execute mvs commands in a mvs job
MVSJob job = new MVSJob()
job.start()
if ("${props.COB3DYN}"== "N" && "${props.@DB2}" == "Y") {
	//	sql.execute()
}
job.stop()


def createSqlCommand(buildFile, logicalFile, C1ELEMENT, logFile) {
	def sql = new MVSExec().pgm("DSNHPC").parm("${props.DB2OPT}")
	sql.dd(new DDStatement().name("TASKLIB").dsn("${props.DB2EXIT}").options("shr"))
	sql.dd(new DDStatement().dsn("${props.DB2LOAD}").options("shr"))
	sql.dd(new DDStatement().name("SYSPRINT").dsn("&&SQLLIST").options('cyl space(5,5) unit(vio) new').pass(true))
	sql.dd(new DDStatement().name("SYSTERM").options("DUMMY"))
	sql.dd(new DDStatement().name("SYSUT1").options("tracks space(15,15) unit(vio) new"))
	sql.dd(new DDStatement().name("SYSUT2").options("tracks space(5,5) unit(vio) new"))
	sql.dd(new DDStatement().name("SYSLIB").dsn("${props.DB2DCLG}").options("shr"))
	sql.dd(new DDStatement().name("DBRMLIB").dsn("${props.dbrmDsn}(${C1ELEMENT})").options("shr"))
	sql.dd(new DDStatement().name("SYSIN").dsn("${props.sysinDsn}(${C1ELEMENT})").options("shr"))	
	sql.dd(new DDStatement().name("SYSCIN").dsn("&&SYSCIN").options('cyl space(5,5) unit(vio) new').pass(true))
}


def createTrnCommand(buildFile, logicalFile, C1ELEMENT, logFile) {
}

def createCompileCommand(buildFile, logicalFile, C1ELEMENT, logFile) {
}

def createLked1Command(buildFile, logicalFile, C1ELEMENT, logFile) {
}

def createLked2Command(buildFile, logicalFile, C1ELEMENT, logFile) {
}

def createDbrmcopyCommand(buildFile, logicalFile, C1ELEMENT, logFile) {
}
