---
layout: page
navbar: Agenda
---

{% for post in site.categories["Agenda"] reverse limit:1 %}
# **{{post.title}}**
{{ post.content }}
{% endfor %}
