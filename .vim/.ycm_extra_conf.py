# Partially stolen from https://bitbucket.org/mblum/libgp/src/2537ea7329ef/.ycm_extra_conf.py
import os
import ycm_core


# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
#
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags. Notice that YCM itself uses that approach.
compilation_database_folder = ''

if compilation_database_folder:
  database = ycm_core.CompilationDatabase( compilation_database_folder )
else:
  database = None


def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )


def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
  if not working_directory:
    return list( flags )
  new_flags = []
  make_next_absolute = False
  path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
  for flag in flags:
    new_flag = flag

    if make_next_absolute:
      make_next_absolute = False
      if not flag.startswith( '/' ):
        new_flag = os.path.join( working_directory, flag )

    for path_flag in path_flags:
      if flag == path_flag:
        make_next_absolute = True
        break

      if flag.startswith( path_flag ):
        path = flag[ len( path_flag ): ]
        new_flag = path_flag + os.path.join( working_directory, path )
        break

    if new_flag:
      new_flags.append( new_flag )
  return new_flags


def FlagsForFile( filename , **kwargs ):
  flags =   [
            '-Wall',
            '-Wextra',
            '-pedantic',
            '-isystem', '/usr/local/include/lua5.1',
            '-isystem', '/System/Library/Frameworks/Python.framework/Headers',
            '-isystem', '/usr/local/include',
            '-isystem', '/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/usr/include',
            '-isystem', '/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/usr/include',
            '-isystem', '/usr/local/include/eigen3',
            '-I', 'include',
            '-I', '../include',
            '-I.'
            ]
  data = kwargs['client_data']
  filetype = data['&filetype']
  if filetype == 'c':
        flags += ['-xc']
        flags += ['-std=c11']
  elif filetype == 'cpp':
        flags += ['-isystem', '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../include/c++/v1/']
        flags += ['-std=c++11']
        flags += ['-xc++']
  else:
        flags = []
  if database:
    # Bear in mind that compilation_info.compiler_flags_ does NOT return a
    # python list, but a "list-like" StringVec object
    compilation_info = database.GetCompilationInfoForFile( filename )
    final_flags = MakeRelativePathsInFlagsAbsolute(
        compilation_info.compiler_flags_,
        compilation_info.compiler_working_dir_ )
  else:
    relative_to = DirectoryOfThisScript()
    final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )
    
  return {
    'flags': flags,
    'do_cache': True
  }


