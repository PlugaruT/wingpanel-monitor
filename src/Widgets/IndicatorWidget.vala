namespace WingpanelMonitor {
    public class IndicatorWidget : Gtk.Box {
        private Gtk.Label label;
        private Gtk.Image icon;
        private Gtk.Revealer widget_revealer;

        public string icon_name { get; construct; }
        public int char_width { get; construct; }

        public string label_value {
            set {label.label = value; }
        }
        
        public string new_icon {
            set {
                icon.set_from_icon_name (value, Gtk.IconSize.SMALL_TOOLBAR);
            }
        }

        public bool display {
            set { widget_revealer.reveal_child = value; }
            get { return widget_revealer.get_reveal_child () ; }
        }

        public IndicatorWidget (string icon_name, int char_width) {
            Object (
                orientation: Gtk.Orientation.HORIZONTAL,
                icon_name: icon_name,
                char_width: char_width
            );
        }

        construct {
            icon = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.SMALL_TOOLBAR);

            var group = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

            label = new Gtk.Label ("N/A");
            label.set_width_chars (char_width);

            group.pack_start (icon);
            group.pack_start (label);

            widget_revealer = new Gtk.Revealer ();
            widget_revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_RIGHT;
            widget_revealer.reveal_child = true;

            widget_revealer.add (group);

            pack_start (widget_revealer);
        }        
    }
}
