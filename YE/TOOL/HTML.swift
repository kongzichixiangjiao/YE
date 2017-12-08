//
//  HTML.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/30.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation

class HTML {
    static func concat(css: [String], body: String) -> String {
        var html = "<html>"
        html += "<head>"
        css.forEach { html += "<link rel=\"stylesheet\" href=\($0)>" }
        html += "<style>img{max-width:320px !important;}</style>"
        html += "</head>"
        html += "<body>"
        html += body
        html += "</body>"
        html += "</html>"
        return html
    }
}
