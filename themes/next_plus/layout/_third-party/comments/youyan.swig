{% if not (theme.duoshuo and theme.duoshuo.shortname)
  and not theme.duoshuo_shortname
  and not theme.disqus_shortname
  and not theme.hypercomments_id %}

  {% if theme.youyan_uid %}
    {% set uid = theme.youyan_uid %}

    {% if page.comments %}
      <!-- UY BEGIN -->
      <script src="{{ url_for(theme.js) }}/src/uyan.js?uid={{uid}}"></script>
      <!-- UY END -->
    {% endif %}
  {% endif %}

{% endif %}
