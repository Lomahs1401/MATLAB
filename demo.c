#include <stdio.h>

// Tinh gia tien cho phan dinh muc
float tinh_tien_dinh_muc(float so_kwh) {
    return so_kwh * 450;
}

// Tinh gia tien cho phan vuot dinh muc
float tinh_tien_vuot_dinh_muc(float so_kwh_vuot_dinh_muc) {
    if (so_kwh_vuot_dinh_muc <= 50) {
        return so_kwh_vuot_dinh_muc * 700;
    } else if (so_kwh_vuot_dinh_muc < 100) {
        return so_kwh_vuot_dinh_muc * 910;
    } else {
        return so_kwh_vuot_dinh_muc * 1200;
    }
}

int main() {
    float chi_so_cu, chi_so_moi, so_kwh, so_kwh_dinh_muc, so_kwh_vuot_dinh_muc, tien_dinh_muc, tien_vuot_dinh_muc, tong_tien;

    do {
        printf("Nhap chi so dien ke thang truoc: ");
        scanf("%f", &chi_so_cu);
        printf("Nhap chi so dien ke thang nay: ");
        scanf("%f", &chi_so_moi);

        if (chi_so_cu >= chi_so_moi) {
            printf("Chi so moi phai lon hon chi so cu. Vui long nhap lai.\n");
        }
    } while (chi_so_cu >= chi_so_moi);

    so_kwh = chi_so_moi - chi_so_cu;
    so_kwh_dinh_muc = (so_kwh < 50) ? so_kwh : 50;
    so_kwh_vuot_dinh_muc = (so_kwh > 50) ? so_kwh - 50 : 0;

    tien_dinh_muc = tinh_tien_dinh_muc(so_kwh_dinh_muc);
    tien_vuot_dinh_muc = tinh_tien_vuot_dinh_muc(so_kwh_vuot_dinh_muc);
    tong_tien = tien_dinh_muc + tien_vuot_dinh_muc;

    printf("So kWh: %.2f\n", so_kwh);
    printf("So kWh dinh muc: %.2f\n", so_kwh_dinh_muc);
    printf("So kWh vuot dinh muc: %.2f\n", so_kwh_vuot_dinh_muc);
    printf("Gia tien dinh muc: %.2f\n", tien_dinh_muc);
    printf("Gia tien vuot dinh muc: %.2f\n", tien_vuot_dinh_muc);
    printf("Tong gia tien: %.2f\n", tong_tien);

    return 0;
}