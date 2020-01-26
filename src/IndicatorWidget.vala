namespace WingpanelMonitor {
    public class IndicatorWidget : Gtk.Box {
        private Gtk.Label percentage_label;
        private Gtk.Revealer widget_revealer;

        public string icon_name { get; construct; }

        public int percentage {
            set { percentage_label.label = "%i%%".printf (value); }
        }

        public bool display {
            set { widget_revealer.reveal_child = value; }
            get { return widget_revealer.get_reveal_child () ; }
        }

        public IndicatorWidget (string icon_name) {
            Object (
                orientation: Gtk.Orientation.HORIZONTAL,
                icon_name: icon_name
            );
        }

        construct {
            var icon = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.SMALL_TOOLBAR);

            var group = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);

            percentage_label = new Gtk.Label ("N/A");
            percentage_label.margin = 2;

            group.pack_start (icon);
            group.pack_start (percentage_label);

            widget_revealer = new Gtk.Revealer();
            widget_revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_RIGHT;
            widget_revealer.reveal_child = true;

            widget_revealer.add(group);

            pack_start (widget_revealer);
        }
    }
}
