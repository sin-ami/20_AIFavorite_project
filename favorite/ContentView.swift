//
//  ContentView.swift
//  favorite
//
//  Created by 小島愛実 on 2026/05/16.
//

import SwiftUI

struct ContentView: View {
    private let homeLinks: [HomeLinkItem] = [
        .init(title: "MATCH SCHEDULE", subtitle: "試合日程", icon: "calendar", destination: .schedule),
        .init(title: "TEAM INFO", subtitle: "チーム情報", icon: "person.3.fill", destination: .team),
        .init(title: "CURRENT RANKING", subtitle: "現在のランキング", icon: "chart.bar.fill", destination: .ranking),
        .init(title: "LACROSSE RULES", subtitle: "ラクロスのルール", icon: "book.fill", destination: .rules)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                LacrosseBackground()
                    .ignoresSafeArea()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 22) {
                        header
                        heroCard

                        Text("PAGES")
                            .font(.headline.weight(.bold))
                            .kerning(1.2)
                            .foregroundStyle(.white)

                        ForEach(homeLinks) { link in
                            NavigationLink(destination: destinationView(for: link.destination)) {
                                HomeLinkCard(link: link)
                            }
                            .buttonStyle(HomePressStyle())
                        }
                    }
                    .frame(maxWidth: 620, alignment: .leading)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 22)
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationBarHidden(true)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("KANSAI UNIVERSITY")
                .font(.caption.weight(.semibold))
                .kerning(2.4)
                .foregroundStyle(Color.white.opacity(0.75))

            Text("LACROSSE HUB")
                .font(.system(size: 32, weight: .heavy, design: .default))
                .foregroundStyle(.white)

            Text("関西大学ラクロスの情報を、1つに。")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(Color.white.opacity(0.84))
        }
    }

    private var heroCard: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color(red: 0.01, green: 0.39, blue: 0.62), Color(red: 0.02, green: 0.12, blue: 0.24)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .strokeBorder(.white.opacity(0.18), lineWidth: 1)
                }
                .overlay(alignment: .topLeading) {
                    Rectangle()
                        .fill(.white.opacity(0.9))
                        .frame(width: 56, height: 3)
                        .padding(.top, 16)
                        .padding(.leading, 20)
                }
                .shadow(color: .black.opacity(0.18), radius: 14, x: 0, y: 8)

            VStack(alignment: .leading, spacing: 10) {
                Text("NEXT FACE-OFF")
                    .font(.caption.weight(.bold))
                    .kerning(1.8)
                    .foregroundStyle(Color.white.opacity(0.8))

                Text("KANDAI vs RITS")
                    .font(.system(size: 24, weight: .black, design: .default))
                    .foregroundStyle(.white)

                Label("1部注目試合: 関西大学 vs 立命館大学", systemImage: "location.fill")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.white.opacity(0.9))
            }
            .padding(20)
        }
        .frame(height: 190)
    }

    @ViewBuilder
    private func destinationView(for destination: HomeDestination) -> some View {
        switch destination {
        case .schedule:
            ScheduleView()
        case .team:
            TeamInfoView()
        case .ranking:
            RankingView()
        case .rules:
            RulesView()
        }
    }
}

private struct HomePressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1.0)
            .opacity(configuration.isPressed ? 0.78 : 1.0)
            .offset(y: configuration.isPressed ? 2 : 0)
            .animation(.spring(response: 0.22, dampingFraction: 0.72), value: configuration.isPressed)
    }
}

private struct HomeLinkCard: View {
    let link: HomeLinkItem

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: link.icon)
                .font(.title3.weight(.bold))
                .foregroundStyle(Color(red: 0.68, green: 0.87, blue: 1.0))
                .frame(width: 28)

            VStack(alignment: .leading, spacing: 4) {
                Text(link.title)
                    .font(.headline.weight(.bold))
                    .foregroundStyle(.white)
                Text(link.subtitle)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Color.white.opacity(0.82))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.callout.weight(.bold))
                .foregroundStyle(Color.white.opacity(0.75))
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(red: 0.05, green: 0.14, blue: 0.23).opacity(0.88))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(.white.opacity(0.14), lineWidth: 1)
        )
    }
}

private struct ScheduleView: View {
    private let sections: [InfoSection] = [
        .init(
            title: "1部",
            items: [
                .init(title: "関西大学 vs 立命館大学", subtitle: "5/24(土) 14:00", detail: "王子スタジアム"),
                .init(title: "関西学院大学 vs 同志社大学", subtitle: "5/24(土) 16:30", detail: "王子スタジアム"),
                .init(title: "京都大学 vs 神戸大学", subtitle: "5/25(日) 11:00", detail: "鶴見緑地球技場")
            ]
        ),
        .init(
            title: "2部",
            items: [
                .init(title: "大阪大学 vs 大阪公立大学", subtitle: "5/25(日) 13:30", detail: "服部緑地球技場"),
                .init(title: "近畿大学 vs 甲南大学", subtitle: "5/31(土) 10:00", detail: "鶴見緑地球技場"),
                .init(title: "龍谷大学 vs 京都産業大学", subtitle: "5/31(土) 12:30", detail: "鶴見緑地球技場")
            ]
        ),
        .init(
            title: "3部",
            items: [
                .init(title: "大阪工業大学 vs 摂南大学", subtitle: "6/1(日) 9:30", detail: "万博記念競技場"),
                .init(title: "追手門学院大学 vs 桃山学院大学", subtitle: "6/1(日) 12:00", detail: "万博記念競技場"),
                .init(title: "佛教大学 vs 大阪経済大学", subtitle: "6/8(日) 15:00", detail: "京都府立山城総合運動公園")
            ]
        )
    ]

    var body: some View {
        GroupedDetailPage(title: "MATCH SCHEDULE", subtitle: "試合日程", sections: sections)
    }
}

private struct TeamInfoView: View {
    private let sections: [InfoSection] = [
        .init(
            title: "1部所属チーム",
            items: [
                .init(title: "関西大学", subtitle: "攻守の切り替えが速い", detail: "関西リーグ上位常連", url: "https://ku-mlax.1net.jp/"),
                .init(title: "立命館大学", subtitle: "組織的ディフェンスが強み", detail: "堅実な試合運び", url: "https://www.ritsumei.ac.jp/sports-culture/sports/group/detail/?id=46"),
                .init(title: "関西学院大学", subtitle: "高いフィジカルと展開力", detail: "速攻の精度が高い", url: "https://www.kglaxmen.com/"),
                .init(title: "同志社大学", subtitle: "パスワーク中心の戦術", detail: "セットオフェンスが特徴", url: "https://shimeta.net/mens/"),
                .init(title: "京都大学", subtitle: "粘り強い守備", detail: "ロースコア展開に強い", url: "https://kyotouniv-lax.jp/"),
                .init(title: "神戸大学", subtitle: "運動量を活かしたミドルライン", detail: "トランジション勝負", url: "https://kobelaxmen.amebaownd.com/")
            ]
        ),
        .init(
            title: "2部所属チーム",
            items: [
                .init(title: "大阪大学", subtitle: "基礎力の高いバランス型", detail: "昇格争い常連", url: "https://osakauniv-menslax.com/"),
                .init(title: "大阪公立大学", subtitle: "堅守速攻", detail: "フェイスオフが安定", url: "https://ocu-lax.com/"),
                .init(title: "近畿大学", subtitle: "アグレッシブな1on1", detail: "得点力が高い", url: "https://kindai-lax.com/"),
                .init(title: "甲南大学", subtitle: "セットプレー重視", detail: "丁寧な試合運び", url: "https://www.konan-u.ac.jp/club/m-lacrosse/m/"),
                .init(title: "龍谷大学", subtitle: "連動した攻守の切り替え", detail: "走力に強み", url: "https://ameblo.jp/ryulax-tatuo/"),
                .init(title: "京都産業大学", subtitle: "フィジカルコンタクトに強い", detail: "終盤の粘りが武器", url: "https://ksulax.net/")
            ]
        ),
        .init(
            title: "3部所属チーム",
            items: [
                .init(title: "大阪工業大学", subtitle: "若手中心の成長株", detail: "アタック陣が活発", url: "https://www.oit.ac.jp/"),
                .init(title: "摂南大学", subtitle: "守備の連携を重視", detail: "失点抑制が課題", url: "https://www.setsunan.ac.jp/campus-life/extracurricular-activities/"),
                .init(title: "追手門学院大学", subtitle: "運動量と粘り強さ", detail: "接戦に強い", url: "https://www.otemon.ac.jp/campus/ex_act/club.html"),
                .init(title: "桃山学院大学", subtitle: "パス展開を丁寧に構築", detail: "技術志向のチーム", url: "https://www.andrew.ac.jp/clubnavi/sports/35.html"),
                .init(title: "佛教大学", subtitle: "組織的なセット守備", detail: "立ち上がりが安定", url: "https://www.bukkyo-u.ac.jp/campuslife/activity/club/athletic/35.html"),
                .init(title: "大阪経済大学", subtitle: "アグレッシブな中盤", detail: "ボール奪取力が高い", url: "https://www.osaka-ue.ac.jp/campus/club/club01/lacrosse_m.html")
            ]
        )
    ]

    var body: some View {
        GroupedDetailPage(title: "TEAM INFO", subtitle: "チーム紹介", sections: sections)
    }
}

private struct RankingView: View {
    private let sections: [InfoSection] = [
        .init(
            title: "1部順位",
            items: [
                .init(title: "1位 京都大学", subtitle: "5勝0敗", detail: "得失点差 +14"),
                .init(title: "2位 関西大学", subtitle: "4勝1敗", detail: "得失点差 +11"),
                .init(title: "3位 関西学院大学", subtitle: "3勝2敗", detail: "得失点差 +6")
            ]
        ),
        .init(
            title: "2部順位",
            items: [
                .init(title: "1位 大阪大学", subtitle: "4勝0敗", detail: "得失点差 +10"),
                .init(title: "2位 近畿大学", subtitle: "3勝1敗", detail: "得失点差 +7"),
                .init(title: "3位 大阪公立大学", subtitle: "2勝2敗", detail: "得失点差 +2")
            ]
        ),
        .init(
            title: "3部順位",
            items: [
                .init(title: "1位 大阪工業大学", subtitle: "3勝0敗", detail: "得失点差 +8"),
                .init(title: "2位 追手門学院大学", subtitle: "2勝1敗", detail: "得失点差 +3"),
                .init(title: "3位 佛教大学", subtitle: "2勝1敗", detail: "得失点差 +1")
            ]
        )
    ]

    var body: some View {
        GroupedDetailPage(title: "CURRENT RANKING", subtitle: "現在のランキング", sections: sections)
    }
}

private struct RulesView: View {
    private let sections: [InfoSection] = [
        .init(
            title: "基本ルール",
            items: [
                .init(title: "基本人数", subtitle: "1チーム 10人", detail: "ATK 3 / MF 3 / DEF 3 / G 1"),
                .init(title: "試合時間", subtitle: "15分 x 4Q", detail: "カテゴリーや大会によって変動あり"),
                .init(title: "ショットクロック", subtitle: "規定時間内にシュート", detail: "攻撃の停滞を防ぐために導入")
            ]
        ),
        .init(
            title: "主な反則",
            items: [
                .init(title: "クロスチェック", subtitle: "スティックの扱いに関する反則", detail: "危険な接触を防止"),
                .init(title: "オフサイド", subtitle: "攻守人数バランス違反", detail: "フィールド内の人数配置ルール"),
                .init(title: "プッシング", subtitle: "背後からの過度な押し", detail: "安全確保のために厳格に判定")
            ]
        )
    ]

    var body: some View {
        GroupedDetailPage(title: "LACROSSE RULES", subtitle: "ラクロスのルール", sections: sections)
    }
}

private struct GroupedDetailPage: View {
    let title: String
    let subtitle: String
    let sections: [InfoSection]

    var body: some View {
        ZStack {
            LacrosseBackground()
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 14) {
                    Text(title)
                        .font(.system(size: 28, weight: .black, design: .default))
                        .foregroundStyle(.white)
                    Text(subtitle)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color.white.opacity(0.82))
                        .padding(.bottom, 8)

                    ForEach(sections) { section in
                        SectionHeader(title: section.title)

                        ForEach(section.items) { item in
                            InfoCard(item: item)
                        }
                    }
                }
                .frame(maxWidth: 620, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.vertical, 22)
                .frame(maxWidth: .infinity)
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline.weight(.bold))
            .foregroundStyle(Color(red: 0.74, green: 0.9, blue: 1.0))
            .padding(.top, 4)
    }
}

private struct InfoCard: View {
    let item: InfoItem

    var body: some View {
        Group {
            if let url = item.url, let destination = URL(string: url) {
                Link(destination: destination) {
                    cardBody(showLinkHint: true)
                }
                .buttonStyle(.plain)
            } else {
                cardBody(showLinkHint: false)
            }
        }
    }

    private func cardBody(showLinkHint: Bool) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                Text(item.title)
                    .font(.headline.weight(.bold))
                    .foregroundStyle(.white)

                Spacer(minLength: 10)

                if showLinkHint {
                    Image(systemName: "arrow.up.right.square")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(Color.white.opacity(0.82))
                }
            }

            Text(item.subtitle)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.white.opacity(0.92))
            Text(item.detail)
                .font(.footnote)
                .foregroundStyle(Color.white.opacity(0.76))

            if showLinkHint {
                Text("ホームページを開く")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.white.opacity(0.78))
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(red: 0.05, green: 0.14, blue: 0.23).opacity(0.9))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(.white.opacity(0.14), lineWidth: 1)
        )
    }
}

private struct LacrosseBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.01, green: 0.08, blue: 0.15),
                    Color(red: 0.02, green: 0.12, blue: 0.20)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            RoundedRectangle(cornerRadius: 1)
                .fill(Color.white.opacity(0.12))
                .frame(height: 1)
                .padding(.horizontal, 22)
                .offset(y: -220)

            RoundedRectangle(cornerRadius: 1)
                .fill(Color.white.opacity(0.1))
                .frame(height: 1)
                .padding(.horizontal, 22)
                .offset(y: 220)

            RoundedRectangle(cornerRadius: 1)
                .fill(Color.white.opacity(0.08))
                .frame(width: 1)
                .padding(.vertical, 120)
        }
    }
}

private enum HomeDestination {
    case schedule
    case team
    case ranking
    case rules
}

private struct HomeLinkItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let destination: HomeDestination
}

private struct InfoItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let detail: String
    let url: String?

    init(title: String, subtitle: String, detail: String, url: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.detail = detail
        self.url = url
    }
}

private struct InfoSection: Identifiable {
    let id = UUID()
    let title: String
    let items: [InfoItem]
}

#Preview {
    ContentView()
}
