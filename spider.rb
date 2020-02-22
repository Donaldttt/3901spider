
require "kimurai"

class CSESpider < Kimurai::Base
  @name='spider'
  @engine=:selenium_firefox
  @start_urls =["https://courses.osu.edu/psc/csosuct/EMPLOYEE/PUB/c/COMMUNITY_ACCESS.CLASS_SEARCH.GBL?PortalActualURL=https%3a%2f%2fcourses.osu.edu%2fpsc%2fcsosuct%2fEMPLOYEE%2fPUB%2fc%2fCOMMUNITY_ACCESS.CLASS_SEARCH.GBL&PortalRegistryName=EMPLOYEE&PortalServletURI=https%3a%2f%2fcourses.osu.edu%2fpsp%2fcsosuct%2f&PortalURI=https%3a%2f%2fcourses.osu.edu%2fpsc%2fcsosuct%2f&PortalHostNode=CAMP&NoCrumbs=yes&PortalKeyStruct=yes"]
  def parse(response, url:, data: {})
    fill_form
    doc=browser.current_response
    check=[]
    while check.length==0
      sleep(5)
      doc=browser.current_response
      check=doc.xpath('//td[@class="PAGROUPBOXLABELLEVEL1"]')
    end
    parse_course doc
  end

  def fill_form()
    campus=browser.find('//*[@id="SSR_CLSRCH_WRK_CAMPUS$0"]')
    campus.select 'Columbus'
    subject=browser.find('//*[@id="SSR_CLSRCH_WRK_SUBJECT_SRCH$1"]')
    subject.select 'Computer Science & Engineering'
    course_number=browser.find('//*[@id="SSR_CLSRCH_WRK_SSR_EXACT_MATCH1$2"]')
    course_number.select 'less than or equal to'
    browser.find('//*[@id="SSR_CLSRCH_WRK_CATALOG_NBR$2"]').fill_in with:"4000"
    submit=browser.find('//*[@id="CLASS_SRCH_WRK2_SSR_PB_CLASS_SRCH"]')
    submit.click
  end

  def parse_course(page)
    courses=page.xpath('.//*[@id="ACE_$ICField$4$$0"]/tbody/tr')
    courses.each do |course|
      course_name=course.xpath('.//td[@class="PAGROUPBOXLABELLEVEL1"]/div/text()')
      sessions=course.xpath('.//table[@width="588"]/tbody/tr/td[@width="586"]/table[@class="PABACKGROUNDINVISIBLE"]/tbody/tr')
      sessions.each do |session|
        session_information=session.xpath('.//td[@align="left"]/div/table[@width="578"]/tbody/tr[@valign="center"]/td')
        if session_information.length!=0
          cla=session_information[0].xpath('.//span/a/text()')
          section=session_information[1].xpath('.//a/text()')
          room=session_information[3].xpath('.//span/text()')
          instructor=session_information[4].xpath('.//span/text()')
          puts course_name
          puts cla
          puts section
          puts room
          puts instructor
          puts "---------------"
        end
      end

    end
  end
end

CSESpider.crawl!


