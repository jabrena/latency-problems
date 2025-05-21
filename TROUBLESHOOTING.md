# Troubleshooting

## How to know the maximum native threads in your system?

```
OSX: sysctl kern.num_threads
OSX: ulimit -u
Linux: cat /proc/sys/kernel/threads-max
```

## What happen if I receive `pthread_create failed (EAGAIN)`?

If you receive the following error message in your tests:

```
[26.110s][warning][os,thread] Failed to start thread - pthread_create failed (EAGAIN) for attributes:
stacksize: 1024k, guardsize: 4k, detached.
Process finished with exit code 130 (interrupted by signal 2: SIGINT)
Caused by: java.lang.OutOfMemoryError: unable to create native thread: possibly out of memory or
process/resource limits reached
```

Review the Test and implementation, it is possible that you are reaching the limit of your hardware.
