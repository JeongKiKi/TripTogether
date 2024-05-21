//
//  DummyModel.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/21.
//

import UIKit

struct Post {
    let description: String
    let photo: UIImage?
}

class DummyModel {
    var dummy: [Post] = [
        Post(description: "해변에서 아름다운 일출.", photo: UIImage(systemName: "backpack.circle")),
        Post(description: "고요한 산 풍경.", photo: UIImage(systemName: "figure.run.square.stack.fill")),
        Post(description: "밤의 도시 불빛.", photo: UIImage(systemName: "snowflake.slash")),
        Post(description: "해먹에서 휴식 중.", photo: UIImage(systemName: "leaf.arrow.circlepath")),
        Post(description: "울창한 숲 탐험.", photo: UIImage(systemName: "tree")),
        Post(description: "고요한 강에서 카약 타기.", photo: UIImage(systemName: "drop.fill")),
        Post(description: "별 아래에서 캠핑.", photo: UIImage(systemName: "tent")),
        Post(description: "황혼의 사막.", photo: UIImage(systemName: "sunset")),
        Post(description: "폭포 근처에서 피크닉.", photo: UIImage(systemName: "drop.circle")),
        Post(description: "한적한 호수에서 낚시.", photo: UIImage(systemName: "fish.circle")),
        Post(description: "전망대에서 본 풍경.", photo: UIImage(systemName: "eye")),
        Post(description: "봄날의 꽃밭.", photo: UIImage(systemName: "camera.macro")),
        Post(description: "도심 속 공원 산책.", photo: UIImage(systemName: "leaf")),
        Post(description: "가을 단풍.", photo: UIImage(systemName: "laurel.leading")),
        Post(description: "겨울 산 정상.", photo: UIImage(systemName: "snow")),
        Post(description: "하늘을 나는 열기구.", photo: UIImage(systemName: "balloon")),
        Post(description: "고요한 바닷가.", photo: UIImage(systemName: "beach.umbrella")),
        Post(description: "해질녘의 농장.", photo: UIImage(systemName: "carrot")),
        Post(description: "산악 자전거 타기.", photo: UIImage(systemName: "bicycle")),
        Post(description: "해변가에서의 바베큐.", photo: UIImage(systemName: "flame"))
    ]
}
