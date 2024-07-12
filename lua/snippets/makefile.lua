local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("make", {
  s("make_vars",{
    t"# ", i(1),
    t{"",
      ".PHONY: all compile build clean",
      "",
      "#? Variables",
      "# STATICLIB, DYNAMICLIB, or EXE # (no space after)",
      "BUILDTYPE = "}, i(2),
    t{"",
      "# COMPILEONLY, LINKONLY, or BOTH # (no space after)",
      "PROCESS = "}, i(3),
    t{"",
      "TARGET_NAME = "}, i(4),
    t{"",
      "# <path-to-dir>",
      "TARGET_PATH = "}, i(5),
    t{"",
      "# Include Directories # -I<path-to-dir>",
      "INCLUDES = \\"}, i(6),
    t{"",
      "# Link Directories # -L<path-to-dir>",
      "LINKDIRS = \\"}, i(7),
    t{"",
      "# Dynamic link files # -l<file-no-extension> or -l:<file-w-extension> # Order from most dependent to least dependent.",
      "DLINKS = \\"}, i(8),
    t{"",
      "# Static link files # -l<file-no-extension> or -l:<file-w-extension> # Order from most dependent to least dependent.",
      "SLINKS = \\"}, i(9),
    t{"",
      "DEFINES = "}, i(9),
    t{"",
      "SRCDIRS = \\"}, i(10),
    t{"",
      "SRCFILES = \\"}, i(11),
    t{"",
      "",
      "#? Constants",
      "OBJDIR = bin/$(TARGET_PATH)",
      "TARGETDIR = build/$(TARGET_PATH)",
      "OBJCLEANDIR = $(OBJDIR)",
      "TARGETCLEANDIR = $(TARGETDIR)"},
    t{"",
      "",
      "#? Custom build cmds",
      "define POSTBUILDCMDS",
      "endef",
      "",
      "include ./newmake/maker.mk"},
  }),
  s("make_maker",{
    t{
      "# maker.mk",
      "",
      "#* First class functions",
      "find_srcs = $(wildcard $(addprefix $(addsuffix /, $(SRCDIR)), $(SRCFILES)))",
      "list_rm = $(wordlist 2, $(words $1), $1)",
      "pairmap = $(and $(strip $2), $(strip $3), $(call $1, $(firstword $2), $(firstword $3)) $(call pairmap, $1, $(call list_rm, $2), $(call list_rm, $3)))",
      "compile_exe_cmd = $(shell $(CXX) $(INCLUDES) -c$1 -o$2)",
      "compile_lib_cmd = $(shell $(CXX) -fPIC $(INCLUDES) -c$1 -o$2)",
      "",
      "#* Constants",
      "SRCS = $(foreach SRCDIR, $(SRCDIRS), $(find_srcs))",
      "OBJECTS = $(addprefix $(OBJDIR)/, $(patsubst %.cpp, %.o, $(SRCFILES)))",
      "TARGET = $(TARGETDIR)/$(TARGET_NAME)",
      "ifeq ($(BUILDTYPE), EXE)",
      "TARGET := $(TARGET).exe",
      "else ifeq ($(BUILDTYPE), STATICLIB)",
      "TARGET := $(TARGET).lib",
      "else ifeq ($(BUILDTYPE), DYNAMICLIB)",
      "TARGET := $(TARGET).dll",
      "endif",
      "",
      "#* Process execution",
      "ifneq ($(filter $(PROCESS), BOTH LINKONLY),)",
      "all: $(TARGET)",
      "\t$(POSTBUILDCMDS)",
      "else ifeq ($(PROCESS), COMPILEONLY)",
      "all: $(OBJECTS)",
      "else",
      "all:",
      "\t@echo error: invalid process",
      "endif",
      "",
      "# Create bin directory",
      "$(OBJDIR):",
      "ifeq ($(wildcard $(OBJDIR)),)",
      "\t@mkdir $(subst /,\\\\,$(OBJDIR))",
      "\t@echo create bin directory",
      "endif",
      "",
      "# Compile sources into objects",
      "$(OBJECTS): $(SRCS) | $(OBJDIR)",
      "\t@echo compile",
      "ifeq ($(BUILDTYPE), EXE)",
      "\t$(call pairmap, compile_exe_cmd, $(SRCS), $(OBJECTS))",
      "else ifneq ($(filter $(BUILDTYPE), STATICLIB DYNAMICLIB),)",
      "\t$(call pairmap, compile_lib_cmd, $(SRCS), $(OBJECTS))",
      "else",
      "\t@echo invalid buildtype",
      "endif",
      "\t@echo compiled",
      "",
      "# Create build directory",
      "$(TARGETDIR):",
      "ifeq ($(wildcard $(TARGETDIR)),)",
      "\t@mkdir $(subst /,\\\\,$(TARGETDIR))",
      "\t@echo create build directory",
      "endif",
      "",
      "# Build target from objects",
      "ifeq ($(PROCESS), LINKONLY)",
      "$(TARGET): | $(TARGETDIR)",
      "else",
      "$(TARGET): $(OBJECTS) | $(TARGETDIR)",
      "endif",
      "\t@echo build",
      "ifeq ($(BUILDTYPE), EXE)",
      "\t$(CXX) $(OBJECTS) $(LINKDIRS) -Wl,-Bstatic $(SLINKS) -Wl,-Bdynamic $(DLINKS) -Wl,--as-needed -o $(TARGET)",
      "else ifeq ($(BUILDTYPE), STATICLIB)",
      "\t$(AR) -rcs $(TARGET) $(OBJECTS)",
      "else ifeq ($(BUILDTYPE), DYNAMICLIB)",
      "\t$(CXX) -shared -o $(TARGET) $(OBJECTS) $(LINKDIRS) -Wl,-Bstatic $(SLINKS) -Wl,-Bdynamic $(DLINKS) -Wl,--as-needed",
      "endif",
      "\t@echo built",
      "",
      "compile: $(OBJECTS)",
      "build: $(TARGET)",
      "\t$(POSTBUILDCMDS)",
      "",
      "clean: ",
      "\t@echo clean",
      "ifneq ($(wildcard $(OBJCLEANDIR)),)",
      "\trmdir /s /q $(subst /,\\\\,$(OBJCLEANDIR))",
      "endif",
      "ifneq ($(wildcard $(TARGETCLEANDIR)),)",
      "\trmdir /s /q $(subst /,\\\\,$(TARGETCLEANDIR))",
      "endif",
      "\t@echo cleaned"
    },
  }),
  s("makefile", {
    t{
      "# makefile",
      ".PHONY: all clean $(MAKES) $(CLEANS)",
      "",
      "export CXX = g++",
      "export AR = ar",
      "",
      "PROJECTS = \\",
      "",
      "MAKES = $(foreach PROJECT, $(PROJECTS), m$(PROJECT))",
      "CLEANS = $(foreach PROJECT, $(PROJECTS), c$(PROJECT))",
      "",
      "all: $(MAKES)",
      "clean: $(CLEANS)",
      "",
      "# Static pattern rules for running sub-makes",
      "$(MAKES): m%: %",
      "\t@$(MAKE) --no-print-directory -f $<",
      "",
      "$(CLEANS): c%: %",
      "\t@$(MAKE) --no-print-directory -f $< clean"
    }
  })
})
