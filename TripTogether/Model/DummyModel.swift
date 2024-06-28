//
//  DummyModel.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/21.
//

import UIKit

struct Postaa {
    let description: String
    let photo: UIImage?
}

class DummyModel {
    var dummy: [Postaa] = [
        Postaa(description: "해변에서 아름다운 일출.", photo: UIImage(systemName: "backpack.circle")),
        Postaa(description: "고요한 산 풍경.", photo: UIImage(systemName: "figure.run.square.stack.fill")),
        Postaa(description: "밤의 도시 불빛.", photo: UIImage(systemName: "snowflake.slash")),
        Postaa(description: "해먹에서 휴식 중.", photo: UIImage(systemName: "leaf.arrow.circlepath")),
        Postaa(description: "울창한 숲 탐험.", photo: UIImage(systemName: "tree")),
        Postaa(description: "고요한 강에서 카약 타기.", photo: UIImage(systemName: "drop.fill")),
        Postaa(description: "별 아래에서 캠핑.", photo: UIImage(systemName: "tent")),
        Postaa(description: "황혼의 사막.", photo: UIImage(systemName: "sunset")),
        Postaa(description: "폭포 근처에서 피크닉.", photo: UIImage(systemName: "drop.circle")),
        Postaa(description: "한적한 호수에서 낚시.", photo: UIImage(systemName: "fish.circle")),
        Postaa(description: "전망대에서 본 풍경.", photo: UIImage(systemName: "eye")),
        Postaa(description: "봄날의 꽃밭.", photo: UIImage(systemName: "camera.macro")),
        Postaa(description: "도심 속 공원 산책.", photo: UIImage(systemName: "leaf")),
        Postaa(description: "가을 단풍.", photo: UIImage(systemName: "laurel.leading")),
        Postaa(description: "겨울 산 정상.", photo: UIImage(systemName: "snow")),
        Postaa(description: "하늘을 나는 열기구.", photo: UIImage(systemName: "balloon")),
        Postaa(description: "고요한 바닷가.", photo: UIImage(systemName: "beach.umbrella")),
        Postaa(description: "해질녘의 농장.", photo: UIImage(systemName: "carrot")),
        Postaa(description: "산악 자전거 타기.", photo: UIImage(systemName: "bicycle")),
        Postaa(description: "해변가에서의 바베큐.", photo: UIImage(systemName: "flame"))
    ]
}
