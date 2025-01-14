from fastapi import FastAPI
import uvicorn

app = FastAPI()

@app.get("/")
async def read_root():
    return {"message": "Hello, HTTPS!"}

if __name__ == "__main__":
    uvicorn.run(
        "main:app",  # Thay "main" bằng tên file của bạn
        host="0.0.0.0",
        port=443,  # Cổng HTTPS mặc định
        ssl_certfile="cert.pem",  # Đường dẫn đến file chứng chỉ
        ssl_keyfile="key.pem"     # Đường dẫn đến file khóa bí mật
    )