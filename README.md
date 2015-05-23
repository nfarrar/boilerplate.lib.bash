boilerplate.lib.bash
====================

     _           _ _                 _       _         _ _ _      _               _
    | |__   ___ (_) | ___ _ __ _ __ | | __ _| |_ ___  | (_) |__  | |__   __ _ ___| |__
    | '_ \ / _ \| | |/ _ \ '__| '_ \| |/ _` | __/ _ \ | | | '_ \ | '_ \ / _` / __| '_ \
    | |_) | (_) | | |  __/ |  | |_) | | (_| | ||  __/_| | | |_) || |_) | (_| \__ \ | | |
    |_.__/ \___/|_|_|\___|_|  | .__/|_|\__,_|\__\___(_)_|_|_.__(_)_.__/ \__,_|___/_| |_|
                              |_|


About
-----
Shell scripts are awesome. And horrible. And easy. And difficult. They're the glue that tie together the average *nix box - and they're horribly ill-suited to reusability, maintainability, and integration. But we still use them, for just about everything.



Settings
--------

| Setting                   | Default Value | Description                                                                       |
| ------------------------: | :------------ | :-------------------------------------------------------------------------------- |
| SCRIPT_PATH               | *             | Path to the 'sourcing script'. This is determined at runtime if not provided.     |
| BOILERPLATE_PATH          | *             | Path to the boilerplate library. This is determined at runtime if not provided.   |
| MODULES_PATH              | modules       | Path to the boilerplate modules. Defaults to 'modules' relative to boilerplate.   |
| REQUIRE_POSIX             | 0             | Require POSIX compatibility.                                                      |
| REQUIRE_BASH32            | 0             | Require BASH32 compatibility.                                                     |
| REQUIRE_STRICT            | 1             | Require strict execution. *Enabled by default.*                                   |
| REQUIRE_SUDO              | 0             | Require EUID = 0.                                                                 |
| REQUIRE_INTERACTIVE       | 0             | Require interactive tty.                                                          |
| CONSOLE_LOGGING           | 1             | Write log messages to the console. *Enabled by default.*                          |
| CONSOLE_LOGLEVEL          | info          | The level for log messages that are written to the console.                       |
| FILE_LOGGING              | 0             | Write log messages to a log file.                                                 |
| FILE_LOGLEVEL             | debug         | The level for log messages that are written to the log file.                      |
| FILE_LOGPATH              | <name.log>    | The path of the log file.                                                         |
| SYSLOG_LOGGING            | 0             | Send log messages to syslog.                                                      |
| SYSLOG_LEVEL              | error         | The level for log messages that are sent to syslog.                               |



