#include <stdio.h>
#include <string.h>

const int Mod = 1e9;
const int N = 12;

int n, m, status[13], f[13][1 << 12];

int isLegal1(int x, int id) { /*״̬ x �ܷ���ڵ� x ��*/
    if ((x & (x >> 1)) != 0) return 0; /*״̬ x �Ƿ������������� 1*/
    if ((x & status[id]) != x) return 0; /*״̬ x �Ƿ������ id �е�״̬*/
    return 1;
}

int isLegal2(int x, int y) { /*״̬ x ��״̬ y �ܷ��������*/
    if ((x & y) != 0) return 0; /*״̬ x ��״̬ y �Ƿ�������*/
    return 1;
}

int main() {
    while (scanf("%d%d", &n, &m) == 2) {
        int x;
        for (int i = 1; i <= n; i ++) {
            status[i] = 0;
            for (int j = 0; j < m; j ++) {
                scanf("%d", &x);
                status[i] |= (x << j);
            }
        }
        memset(f, 0, sizeof(f));
        f[0][0] = 1;
        for (int i = 1; i <= n; i ++) {
            for (int j = 0; j < (1 << m); j ++)
            for (int k = 0; k < (1 << m); k ++) {
                if (isLegal1(k, i) && isLegal2(j, k)) {
                    f[i][k] = (f[i][k] + f[i - 1][j]) % Mod;
                }
            }
        }
        int result = 0;
        for (int i = 0; i < (1 << m); i ++) {
            result = (result + f[n][i]) % Mod;
        }
        printf("%d\n", result);
    }
}
