$(document).ready(function () {

    // gnb
    $('.gnb_1st > li> a').click(function () {
        if ($(this).hasClass('on') === false) {
            $('.gnb_1st > li > a ').removeClass('on')
            $(this).addClass('on')
            $('.gnb_2nd').removeClass('on')
            $(this).next().slideDown(300).addClass('on')
        } else {
            $('.gnb_1st > li > a ').removeClass('on')
            $(this).next().slideToggle(200).siblings('.url').slideUp(200)
        }
    })
    $('.gnb_2nd > li').click(function () {
        $('.gnb_2nd > li').removeClass('on')
        $(this).addClass('on')
    })

    // main 인기검색어
    $('.tab_li01').click(function () {
        $('.tab_li01').removeClass('on')
        $(this).addClass('on')
    })

    // 그래프로 보기
    $('.stick_wrap').click(function () {
        $('.stick_wrap').removeClass('on')
        $(this).addClass('on')
    })

    // 게시글 바로가기
    $('.gal_bot >ul >li').click(function () {
        $('.gal_bot >ul >li').removeClass('on')
        $(this).addClass('on')
    })
    // 빠른예약
    $('.sty02_btn > li').click(function () {
        let idx = $(this).index()
        // tab_btn
        $('.sty02_btn > li').removeClass('on')
        $(this).addClass('on')
        // 내용물 보이게 하기
        $('.sty02_con').removeClass('on')
        $('.sty02_con').eq(idx).addClass('on')
    })

    // index03 
        // main tab
        $('.tab03_li').click(function () {
            $('.tab03_li').removeClass('on')
            $(this).addClass('on')
        })

        // date btn
        $('.up_date > ul >li').click(function () {
            $('.up_date > ul >li').removeClass('on')
            $(this).addClass('on')
        })

        // table_sty01
        $('.table_sty01 tbody tr').click(function () {
            $('.table_sty01 tbody tr').removeClass('on')
            $(this).addClass('on')
        })
        $('.table01_paging > ol li').click(function () {
            $('.table01_paging > ol li').removeClass('on')
            $(this).addClass('on')
        })

        // index06
        // mask 
        $('.mask_calendar').click(function(){
            $('.mask').addClass('on')
        })
        // close
        $('.btn_x').click(function(){
            $('.mask').removeClass('on')
        })

        // 태그
        $('.tag').click(function(){
            $('.tag > img').attr("src", "images/tag_off.png")
            $(this).find('img').attr("src", "images/tag_on.png");
            $('.tag_box').removeClass('on')
            $(this).next('.tag_box').addClass('on')
        })

        // profile
        $('.profile_img').click(function(){
            $(this).find('img').attr("src", "images/ico_plus.png").addClass('on')
        })
})
