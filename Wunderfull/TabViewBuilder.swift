//
//  TabViewBuilder.swift
//  Wunderfull
//
//  Created by Peter Pult on 26/11/2016.
//  Copyright © 2016 Peter Pult. All rights reserved.
//

import Segmentio
import UIKit

struct TabViewBuilder {
    
    static func buildTabView(tabView: Segmentio, style: SegmentioStyle) {
        tabView.setup(
            content: content(),
            style: style,
            options: options(style: style)
        )
    }
    
    private static func content() -> [SegmentioItem] {
        return [
            SegmentioItem(title: "List", image: nil),
            SegmentioItem(title: "Map", image: nil)
        ]
    }
    
    private static func options(style: SegmentioStyle) -> SegmentioOptions {
        var imageContentMode = UIViewContentMode.center
        switch style {
        case .imageBeforeLabel, .imageAfterLabel:
            imageContentMode = .scaleAspectFit
        default:
            break
        }
        
        return SegmentioOptions(
            backgroundColor: UIColor.white,
            maxVisibleItems: 2,
            scrollEnabled: false,
            indicatorOptions: indicatorOptions(),
            horizontalSeparatorOptions: horizontalSeparatorOptions(),
            verticalSeparatorOptions: verticalSeparatorOptions(),
            imageContentMode: imageContentMode,
            labelTextAlignment: .center,
            segmentStates: states()
        )
    }
    
    private static func states() -> SegmentioStates {
        let font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin)
        return SegmentioStates(
            defaultState: SegmentioState(
                backgroundColor: UIColor.clear,
                titleFont: font,
                titleTextColor: UIColor.darkGray
            ),
            selectedState: SegmentioState(
                backgroundColor: UIColor.clear,
                titleFont: font,
                titleTextColor: UIColor.black
            ),
            highlightedState: SegmentioState(
                backgroundColor: UIColor.clear,
                titleFont: font,
                titleTextColor: UIColor.darkGray
            )
        )
    }
    
    private static func segmentioState(backgroundColor: UIColor, titleFont: UIFont, titleTextColor: UIColor) -> SegmentioState {
        return SegmentioState(
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            titleTextColor: titleTextColor
        )
    }
    
    private static func indicatorOptions() -> SegmentioIndicatorOptions {
        return SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 6,
            color: UIColor.orange
        )
    }
    
    private static func horizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(
            type: .topAndBottom,
            height: 0,
            color: UIColor.clear
        )
    }
    
    private static func verticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(
            ratio: 0,
            color: UIColor.clear
        )
    }
    
}
