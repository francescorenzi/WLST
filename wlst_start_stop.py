from __future__ import print_function
from contextlib import contextmanager
import time
import signal

############
# definizione funzione di timeout
############
@contextmanager
def timeout(time):
    signal.signal(signal.SIGALRM, raise_timeout)
    signal.alarm(time)
    try:
        yield
    except TimeoutError:
        pass
    finally:
        signal.signal(signal.SIGALRM, signal.SIG_IGN)


def raise_timeout(signum, frame):
    raise TimeoutError


############
# connessione al server
############
def connect(username, password, url):
    connect('weblogic', 'Weblogic_Svil', 't3://172.31.138.15:7001')
    with timeout(60):
        print('timeout')
        import time
        time.sleep(10)
#       return 1;


if connect('weblogic', 'Weblogic_Svil', 't3://172.31.138.15:7001') > 0:
    print(connect(), 'connect_failed.txt')
else:
    print("connessione riuscita")
    time.sleep(3)


############
# stop
############
def shutdown(server, force):
    shutdown('Server_1', 'true')
    with timeout(60):
        print('timeout')
        import time
        time.sleep(10)
    if shutdown('Server_1', 'true') > 0:
        return 1
    else:
        print("server 1 disconnesso")

    shutdown('Server_2', 'true')
    with timeout(60):
        print('timeout')
        import time
        time.sleep(10)
    if shutdown('Server_2', 'true') > 0:
        return 1
    else:
        print("server 2 disconnesso")


############
# start
############
def start(server):
    start('Server_1', 'Server')
    with timeout(60):
        print('timeout')
        import time
        time.sleep(10)
    if start('Server_1', 'Server') > 0:
        return 1
    else:
        print("server 1 connesso")

    start('Server_2', 'Server')
    with timeout(60):
        print('timeout')
        import time
        time.sleep(10)
    if start('Server_1', 'Server') > 0:
        return 1
    else:
        print("server 1 connesso")


############
# stato
############
def state(server):
    state('Server_1')
    print(state(), 'stato_server1.txt')
    state('Server_2')
    print(state(), 'stato_server1.txt')
    return
