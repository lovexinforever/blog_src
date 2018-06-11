{# Gallery support #}
      {% if config.advert %}
        <div class="post-gallery" itemscope itemtype="http://schema.org/ImageGallery">
          {% set COLUMN_NUMBER = 3 %}
          {% for advert, link in config.advert %}
            {% if loop.index0 % COLUMN_NUMBER === 0 %}<div class="post-gallery-row">{% endif %}
              <a class="post-gallery-img fancybox"
                 href="{{ link.split('||')[1] | trim }}" rel="gallery_{{ post._id }}" target="_blank"
                 itemscope itemtype="http://schema.org/ImageObject" itemprop="url">
                <img src="{{ link.split('||')[0] | trim }}" itemprop="contentUrl" alt="{{advert}}"/>
              </a>
            {% if loop.index0 % COLUMN_NUMBER === 2 %}</div>{% endif %}
          {% endfor %}

          {# Append end tag for `post-gallery-row` when (photos size mod COLUMN_NUMBER) is less than COLUMN_NUMBER #}
          {% if config.advert.length % COLUMN_NUMBER > 0 %}</div>{% endif %}
        </div>
      {% endif %}