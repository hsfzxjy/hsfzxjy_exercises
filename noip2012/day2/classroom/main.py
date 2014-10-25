f = open('main.in', 'r')
n, m = map(int, f.readline().split())
data = map(int, f.readline().split())
print 'init', data
for i in range(m):
    d, s, t = map(int, f.readline().split())
    for j in range(s-1, t):
        data[j] -= d
    print 'op%d: %s' % (i+1, data)
f.close()