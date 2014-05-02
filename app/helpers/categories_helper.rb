module CategoriesHelper
	def display_segment( node )		
		html = "<li>"
		node_class = node.children.length == 0 ? "file" : "folder"
		html << "<span class=\"#{node_class}\">#{node.title} - #{node.id}</span>"
		html << "<ul id=\"children_of_#{h(node.parent_id)}\">"
		node.children.each{|child_node|

			html << display_segment( child_node )
		}
		html << "</ul></li>"
		html.html_safe
	end
end
