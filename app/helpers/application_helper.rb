module ApplicationHelper
  def only_host_and_path(url_string)
    return if url_string.blank?

    uri = URI.parse(url_string)
    "#{uri.host}#{uri.path}"
  rescue
    url_string
  end
end
