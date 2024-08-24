// ฟังก์ชันสำหรับโหลดไฟล์ CSS
function loadCSS(filePath) {
    const link = document.createElement('link');
    link.rel = 'stylesheet'; // กำหนดให้เป็นประเภท CSS
    link.href = filePath; // ระบุที่อยู่ของไฟล์ CSS
    document.head.appendChild(link); // เพิ่มลิงค์ CSS ลงใน head ของเอกสาร
}

// ฟังก์ชันสำหรับแทรก HTML ของ loader
function insertLoaderHTML(html) {
    // รอจนกว่าหน้าเพจจะโหลดเสร็จสมบูรณ์ก่อนแทรก HTML
    document.addEventListener('DOMContentLoaded', () => {
        document.body.insertAdjacentHTML('beforeend', html); // แทรก HTML ของ loader ลงในท้ายสุดของ body
    });
}

// การตั้งค่าของ renderer
const rendererConfig = {
    hostElement: document.querySelector("#flutter_app"), // เลือก element ที่จะใช้ renderer
    renderer: "html" // ระบุประเภทของ renderer
};

// HTML ของ loader ที่ใช้ร่วมกัน
const loaderHTML = `
    <div id="loader">
        <h1 id="melon-loader-title">กำลังโหลด...</h1>
        <div class="circle-loader"></div>
    </div>
`;

// รายการของ models ที่เฉพาะเจาะจงสำหรับแต่ละ path
const pathModels = [
    {
        path: "/sushiro", // เส้นทางที่ตรงกับ model นี้
        cssFile: "loaders/sushiro-loader.css", // ที่อยู่ของไฟล์ CSS สำหรับ path นี้
        loaderHTML: loaderHTML, // HTML ของ loader
        rendererConfig: rendererConfig // การตั้งค่า renderer
    },
    // เพิ่ม models อื่น ๆ ตามที่ต้องการ
];

// โมเดลเริ่มต้นสำหรับกรณีที่ไม่พบ path ที่ตรง
const defaultModel = {
    cssFile: "loaders/default-loader.css", // ที่อยู่ของไฟล์ CSS สำหรับโมเดลเริ่มต้น
    loaderHTML: loaderHTML, // HTML ของ loader
    rendererConfig: rendererConfig // การตั้งค่า renderer
};

// ค้นหาโมเดลที่ตรงกับ path ปัจจุบัน หรือใช้โมเดลเริ่มต้น
const currentPathModel = pathModels.find(model => model.path === window.location.pathname) || defaultModel;

// โหลดไฟล์ CSS ที่เกี่ยวข้องกับโมเดลปัจจุบัน
loadCSS(currentPathModel.cssFile);

// แทรก HTML ของ loader ตามโมเดลที่เลือก
insertLoaderHTML(currentPathModel.loaderHTML);
