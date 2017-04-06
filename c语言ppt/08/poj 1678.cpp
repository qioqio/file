



int F[100000], n, Num[100000], A, B, T;

int Gao(int x) {
    if (F[x] != -Inf) {
        return F[x];
    }
    F[x] = Inf;
    for (int i = x + 1; i < n; i ++) {
        if (Num[i] - Num[x] >= A && Num[i] - Num[x] <= B) {
            F[x] = min(F[x], Num[x] - Gao(i));
        }
    }
    if (F[x] == Inf) {
        F[x] = Num[x];
    }
    return F[x];
}

int main() {
    scanf("%d%d%d", &n, &A, &B);
    printf("~");
    for (int i = 0; i < n; i ++) {
        F[i] = -Inf;
        scanf("%d", &Num[i]);
    }
    sort(Num, Num + n);
    int result = 0;
    for (int i = 0; i < n; i ++) {
        if (Num[i] >= A && Num[i] <= B && Gao(i) > 0) {
            result = 1;
        }
    }
    printf("%d\n", result);
}
