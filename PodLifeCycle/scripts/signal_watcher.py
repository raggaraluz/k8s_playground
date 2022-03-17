from time import sleep
import signal, os, sys

def sigterm_handler(_signo, _stack_frame):
    # Raises SystemExit(0):
    print (f"Gradful shutdown started", flush=True)
    sleep(int(os.getenv('SHUTDOWN_DELAY')))
    print (f"Graceful shutdown ended\n", flush=True)
    sys.exit(0)

if os.getenv("POD_MODE") == "true":
    sys.stdout = open('/proc/1/fd/1', 'a')

signal.signal(signal.SIGTERM, sigterm_handler)

pid = os.getpid()
print(f"Hello, my pid is {pid}", flush=True)
i = 0
while True:
    if os.path.exists('/tmp/ok'):
        i += 1
        print (f"Iteration #{i}", flush=True)
    sleep(1)

