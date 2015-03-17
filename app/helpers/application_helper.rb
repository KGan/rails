module ApplicationHelper
  def csrf_inject
    (<<-HTML).html_safe
    <input type="hidden"
           name="authenticity_token"
           value=#{form_authenticity_token}>
    HTML
  end

  def url_h(obj, prefix = nil, singular = false)
    class_name = obj.class.name.downcase # User => 'users'
    class_name = class_name.pluralize unless singular # 'users'
    method_name = :"#{prefix ? prefix + "_" : ''}#{class_name}_url" # 'new_users_url'
    Rails.application.routes.url_helpers.send method_name, obj.id
  end

  def owns?(item)
    current_user.admin? || (item.try(:user_id) == current_user.id)
  end

  def render_heirarchy(heirarchy)
   return unless heirarchy
   html_string = "Posted To: "
   heirarchy.each do |elem|
     html_string += link_to elem.title, url_h(elem, nil, true)
     html_string += " | "
   end
   html_string.html_safe
 end

 def comment_tree(commentable, children_hash)
  children = children_hash[commentable.id]
   html="<li>#{render 'shared/comment', comment: commentable}</li>"
   if children.empty?
     return html.html_safe
   else
     children.each do |comment|
       html+="<ul>"
       html+= comment_tree(comment, children_hash)
       html+="</ul>"
     end
     html.html_safe
   end
 end

  def comment_options(comment)
    if comment.user_id == current_user.id
      (<<-HTML).html_safe
      <div class="dropdown">
        <a class="dropdown-toggle"    href='#' data-toggle="dropdown"
                                      role="button"
                                      aria-expanded="false"><span class="caret"></span></a>
        <ul class='dropdown-menu' role='menu'>
            <li role="presentation" >#{link_to "Delete Comment", comment_url(comment), method: :delete }</li>
        </ul>
      </div>
      HTML
    end
  end

  
end
