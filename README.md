<h1 align="center">🍈 Melonkemo</h1>

<p align="center">
  เว็บส่วนตัวของเมล่อน เขียนด้วย Flutter ตัวเดียวจบ รันได้ทั้งเว็บ มือถือ ยันเดสก์ท็อป
</p>

<p align="center">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.22.0-02569B?logo=flutter&logoColor=white">
  <img alt="Dart" src="https://img.shields.io/badge/Dart-3.4+-0175C2?logo=dart&logoColor=white">
  <img alt="Firebase" src="https://img.shields.io/badge/Hosting-Firebase-FFCA28?logo=firebase&logoColor=black">
  <img alt="Platforms" src="https://img.shields.io/badge/platform-web%20%7C%20iOS%20%7C%20Android%20%7C%20desktop-lightgrey">
</p>

<p align="center">
  🌐 <a href="https://melonkemo.com">melonkemo.com</a> · 🔌 API: <code>api.melonkemo.com</code>
</p>

---

## มีอะไรในนี้บ้าง

- **หน้า Home / Me** — หน้าแรกกับหน้าโปรไฟล์ มีเจ้าแมว Rive เด้งไปเด้งมาให้ดูเพลินๆ
- **Login** — ล็อกอินเก็บ token ไว้ใน secure storage มี refresh token ให้ด้วย แยกหน้ามือถือกับแท็บเล็ตคนละเลย์เอาต์
- **Sushiro** — ตัวหารค่าจานซูชิกับเพื่อน ใส่คนเข้าไป เลือกจานตามสี แล้วมันสรุปให้ว่าใครจ่ายเท่าไหร่ (จานดำ 100 บาทนะ ไม่ใช่ 120 แล้ว 555)
- **Menu** — รวมทางเข้าไปแต่ละหน้า
- ที่เหลือหลายหน้ายังขึ้น *under construction* อยู่ ค่อยๆ ทำ

ทำ responsive ไว้ มือถือ/แท็บเล็ต/จอใหญ่ ปรับเลย์เอาต์เอง ฟอนต์ไทยเลือกมาหลายตัว (Bai Jamjuree, Mali, M PLUS Rounded ฯลฯ)

## ของที่ใช้

- Flutter **3.22.0** (ล็อกเวอร์ชันไว้ใน `.fvmrc` ใช้ [FVM](https://fvm.app) จะสบายกว่า)
- `provider` จัดการ state, `go_router` ทำ routing
- `dio` ยิง API, `flutter_secure_storage` เก็บ token
- `rive` ทำแอนิเมชันแมว, `flutter_animate` กับ `shimmer` แต่งลูกเล่น
- โมดัล/ชีตใช้ `wolt_modal_sheet`, `modal_bottom_sheet`, `fluid_dialog`

## เริ่มยังไง

```bash
# ใช้ fvm ล็อกเวอร์ชัน (แนะนำ)
fvm install
fvm flutter pub get

# รันเว็บ
fvm flutter run -d chrome
```

ไม่ได้ใช้ fvm ก็ `flutter pub get` แล้ว `flutter run` ตรงๆ ได้ แต่ระวังเวอร์ชัน Flutter ให้ตรงกันหน่อย

## เอาขึ้น

Deploy ผ่าน Firebase Hosting เอาไฟล์จาก `build/web`

```bash
fvm flutter build web
firebase deploy
```

ปกติ push ขึ้น `master` แล้ว GitHub Actions (ในโฟลเดอร์ `.github/workflows/`) จัดการ deploy ให้เอง ไม่ต้องทำมือ

## โครงไฟล์คร่าวๆ

```
lib/
├── core/          # ของกลาง — helper, extension, component ที่ใช้ซ้ำทั้งแอป
├── components/    # widget ย่อยๆ อย่าง bottom sheet, empty state
├── models/        # data model (auth ฯลฯ)
└── pages/         # แต่ละหน้า: home, me, menu, login, sushiro ...
```

---

โปรเจกต์ส่วนตัว เขียนเล่นๆ ตามใจ ไม่ได้เปิดรับ contribution แต่ถ้าเจอบั๊กแปลกๆ ทักมาได้
