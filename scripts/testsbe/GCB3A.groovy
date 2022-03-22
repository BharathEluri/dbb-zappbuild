import com.ibm.dbb.build.MVSExec



@Field BuildProperties props = BuildProperties.getInstance()

MVSExec sql = createSqlCommand(buildFile, logicalFile, C1ELEMENT, logFile)
MVSExec syscincopy = createSyscinCopyCommand(buildFile, logicalFile, C1ELEMENT, logFile)
MVSExec trn = createTrnCommand(buildFile, logicalFile, C1ELEMENT, logFile)
MVSExec syspunchcopy = createSyspunchCopyCommand(buildFile, logicalFile, C1ELEMENT, logFile)
MVSExec compile = createCompileCommand(buildFile, logicalFile, C1ELEMENT, logFile)
MVSExec lked1 = createLked1Command(buildFile, logicalFile, C1ELEMENT, logFile)
MVSExec lked2 = createLked2Command(buildFile, logicalFile, C1ELEMENT, logFile)
MVSExec dbrmcopy = createDbrmcopyCommand(buildFile, logicalFile, C1ELEMENT, logFile)

// execute mvs commands in a mvs job
MVSJob job = new MVSJob()
job.start()
if ("${props.COB3DYN}"== "N" && "${props.@DB2}" == "Y") {
	//	def sqlrc = sql.execute()
	if (sqlrc > 4)
		println("Pre Compile failed!  RC=$sqlrc")
	else
	{
		println("Pre Compile successful!  RC=$sqlrc")
		def copyrc= copySyscIn.execute()
		if (copyrc > 4)
			println("copy failed!  RC=$copyrc")
		else
			println("copy successful!  RC=$copyrc")
	}
}
job.stop()


def createSqlCommand(buildFile, logicalFile, C1ELEMENT, logFile) {
	def sql = new MVSExec().pgm("DSNHPC").parm("${props.DB2OPT}")
	sql.dd(new DDStatement().name("TASKLIB").dsn("${props.DB2EXIT}").options("shr"))
	sql.dd(new DDStatement().dsn("${props.DB2LOAD}").options("shr"))
	sql.dd(new DDStatement().name("SYSPRINT").dsn("&&SQLLIST").options("cyl space(5,5) unit(vio) new").pass(true))
	sql.dd(new DDStatement().name("SYSTERM").options("DUMMY"))
	sql.dd(new DDStatement().name("SYSUT1").options("tracks space(15,15) unit(vio) new"))
	sql.dd(new DDStatement().name("SYSUT2").options("tracks space(5,5) unit(vio) new"))
	sql.dd(new DDStatement().name("SYSLIB").dsn("${props.DB2DCLG}").options("shr"))
	sql.dd(new DDStatement().name("DBRMLIB").dsn("${props.dbrmDsn}(${C1ELEMENT})").options("shr"))
	sql.dd(new DDStatement().name("SYSIN").dsn("${props.sysinDsn}(${C1ELEMENT})").options("shr"))
	sql.dd(new DDStatement().name("SYSCIN").dsn("&&SYSCIN").options('cyl space(5,5) unit(vio) new').pass(true))

}

def createSyscinCopyCommand(String buildFile, LogicalFile logicalFile, String C1ELEMENT, File logFile) {
	def syscincopy = new MVSExec().pgm("IEBGENER")
	syscincopy.dd(new DDStatement().name("SYSUT1").dsn("&&SYSCIN").options("shr"))
	syscincopy.dd(new DDStatement().name("SYSUT2").dsn("${props.sysinDsn}(${C1ELEMENT}").options("shr"))
	return syscincopy
}



def createTrnCommand(buildFile, logicalFile, C1ELEMENT, logFile) {
	def trn = new MVSExec().pgm("DFHECP1\$").parm("${props.CITRNOPT}")
	trn.dd(new DDStatement().name("TASKLIB").dsn("${props.CICSLOAD}").options("shr"))
	//	trn.dd(new DDStatement().name("SYSPRINT").dsn("&&TRNLIST").options("cyl space(1,2) unit(vio) new").pass(true))
	trn.dd(new DDStatement().name("SYSIN").dsn("${props.sysinDsn}(${C1ELEMENT})").options("shr"))
	trn.dd(new DDStatement().name("SYSPUNCH").dsn("&&SYSPUNCH").options("tracks space(15,5) unit(vio) new").pass(true))
	return trn
}

def createSyspunchCopyCommand(String buildFile, LogicalFile logicalFile, String C1ELEMENT, File logFile) {
	def syspunchcopy = new MVSExec().pgm("IEBGENER")
	syspunchcopy.dd(new DDStatement().name("SYSUT1").dsn("&&SYSPUNCH").options("shr"))
	syspunchcopy.dd(new DDStatement().name("SYSUT2").dsn("${props.sysinDsn}(${C1ELEMENT}").options("shr"))
	return syspunchcopy
}
def createCompileCommand(buildFile, logicalFile, C1ELEMENT, logFile) {
}

def createLked1Command(buildFile, logicalFile, C1ELEMENT, logFile) {
}

def createLked2Command(buildFile, logicalFile, C1ELEMENT, logFile) {
}

def createDbrmcopyCommand(buildFile, logicalFile, C1ELEMENT, logFile) {
}


