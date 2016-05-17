alertTemplate = (title, description) ->
  alertString = """
  <?xml version='1.0' encoding='UTF-8' ?>
  <document>
    <alertTemplate>
      <title>#{ escapeHTML title }</title>
      <description>#{ escapeHTML description }</description>
    </alertTemplate>
  </document>
  """
  new DOMParser().parseFromString(alertString, 'application/xml')

listTemplate = (title, files) ->
  listHeader = """
  <?xml version='1.0' encoding='UTF-8' ?>
    <document>
    <listTemplate>
      <list>
        <header>
          <title>#{ title }</title>
        </header>
        <section>
  """
  listFooter = """
        </section>
      </list>
    </listTemplate>
  </document>
  """
  list = files.map (file) -> listItemTemplate(file)
  new DOMParser().parseFromString(listHeader + list.join('') + listFooter, 'application/xml')

listItemTemplate = (file) ->
  itemHeader = """
  <listItemLockup id='#{ file.id }'>
    <title>#{ file.name }</title>
    <img src="#{ file.icon }" width="60" height="60" />
  """
  itemRelated = if file.fileType == 'movie'
    """
    <relatedContent>
      <lockup>
        <img src="#{ file.screenshot }" />
        <description>#{ file.name }<br />#{ file.duration }</description>
      </lockup>
    </relatedContent>
    """
  else
    """
    <decorationImage src="resource://chevron" />
    <relatedContent>
      <lockup>
      </lockup>
    </relatedContent>
    """
  itemFooter = '</listItemLockup>'
  itemHeader + itemRelated + itemFooter

loadingTemplate = (title = 'Loading...') ->
    template = """
    <?xml version="1.0" encoding="UTF-8" ?>
      <document>
        <loadingTemplate>
          <activityIndicator>
            <title>#{title}</title>
          </activityIndicator>
        </loadingTemplate>
      </document>
    """
    new DOMParser().parseFromString template, "application/xml"

loginTemplate = () ->
  template = """
  <?xml version="1.0" encoding="UTF-8" ?>
  <document>
    <formTemplate>
      <banner>
        <title>Put.io Login</title>
        <description>In order to use Put.io you will need access token.<br />To obtain one please visit https://imanel.org/putio-tvos and follow instructions visible on screen.</description>
      </banner>
      <textField>Access Token</textField>
      <footer>
        <button>
          <text>Login</text>
        </button>
      </footer>
    </formTemplate>
  </document>
  """
  new DOMParser().parseFromString template, "application/xml"
