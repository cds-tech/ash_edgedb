ExUnit.start()
ExUnit.configure(stacktrace_depth: 100)

AshEdgeDB.TestRepo.start_link()
AshEdgeDB.TestNoSandboxRepo.start_link()
