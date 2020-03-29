This is some *formatted* text!

{{ d['code.py|pyg'] }}

The result:
{{ d['code.py|py|pyg'] }}

Console view:
{{ d['code.py|pycon|pyg'] }}

here's an image:
[Swatch]({{ d['swatch.png|zulip'].from_json()['url'] }})

