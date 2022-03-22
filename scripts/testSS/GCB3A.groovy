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


def createSqlCommand(buildFile, logicalFile, member, logFile) {

	def sql = new MVSExec().pgm("DSNHPC").parm("${props.DB2OPT}")
	sql.dd(new DDStatement().name("TASKLIB").dsn("${props.DB2EXIT}").options("shr"))
	sql.dd(new DDStatement().dsn("${props.DB2LOAD}").options("shr"))
	sql.dd(new DDStatement().name("SYSPRINT").dsn("&&SQLLIST").options('cyl space(5,5) unit(vio) new').pass(true))
	sql.dd(new DDStatement().name("SYSTERM").options("DUMMY"))
	sql.dd(new DDStatement().name("SYSUT1").options("trk space(15,15) unit(vio) new"))
	sql.dd(new DDStatement().name("SYSUT2").options("trk space(5,5) unit(vio) new"))
	sql.dd(new DDStatement().name("SYSLIB").dsn("${props.DB2DCLG}").options("shr"))
	sql.dd(new DDStatement().name("DBRMLIB").dsn("&&DBRM"("${props.C1ELEMENT}").options("cyl space(1,1,1) unit(work) new recfm(F,B) blksize(80)").pass(true)))
	sql.dd(new DDStatement().name("SYSIN").dsn("&&ELEMOUT").options('shr'))
	sql.dd(new DDStatement().name("SYSCIN").dsn("&&SYSCIN").options('cyl space(5,5) unit(vio) new').pass(true))
}


def createTrnCommand(buildFile, logicalFile, member, logFile) {
}
def trn = new MVSExec().pgm("DFHECP1$").parm("{props.CITRNOPT}")
trn.dd(new DDStatement().name("STEPLIB").dsn("${props.CICSLOAD}")
trn.dd(new DDStatement().name("SYSPRINT").dsn("&&TRNLIST")("cyl space(5,5) unit(vio) new").pass(true))
//if????? DB2=n (ELmount), DB2=y (SYSCIN) 
trn.dd(new DDStatement().name("SYSIN").dsn("${props.sysinDsn}(${C1ELEMENT})").options("shr"))
trn.dd(new DDStatement().name("Syspunch").dsn("&&SYSPUNCH")
.options("tracks space(15,5) unit(vio) new recfm(F,B) blksize(80) lrecl(80)").pass(

def createCompileCommand(buildFile, logicalFile, member, logFile) {
}

def createLked1Command(buildFile, logicalFile, member, logFile) {
}

def createLked2Command(buildFile, logicalFile, member, logFile) {
}

def createDbrmcopyCommand(buildFile, logicalFile, member, logFile) {
}
