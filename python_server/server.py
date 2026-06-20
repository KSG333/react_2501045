from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# 직접 관리할 데이터 (여기서 내용을 마음껏 수정하세요!)
# 책 제목별로 리뷰 목록을 매핑해두면 편합니다.
manual_reviews = {
    "기본": [
        {"site": "독자 리뷰", "rating": "5.0", "comment": "정말 감명 깊게 읽었습니다."},
        {"site": "전문가 평", "rating": "4.5", "comment": "올해 최고의 도서로 추천합니다."}
    ]
}

@app.get("/reviews")
def get_reviews(title: str):
    # 이제 크롤링 없이 바로 데이터를 반환합니다.
    reviews = manual_reviews.get(title, manual_reviews["기본"])
    return {"status": "success", "reviews": reviews}