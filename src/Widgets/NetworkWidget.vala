/*-
 * Copyright (c) 2020 Tudor Plugaru (https://github.com/PlugaruT/wingpanel-monitor)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA.
 *
 * Authored by: Tudor Plugaru <plugaru.tudor@gmail.com>
 */

namespace WingpanelMonitor {
    public class NetworkWidget : Gtk.Grid {
        private Gtk.Revealer widget_revealer;
        private Gtk.Label upload_label;
        private Gtk.Label download_label;

        public bool display {
            set { widget_revealer.reveal_child = value; }
            get { return widget_revealer.get_reveal_child () ; }
        }

        construct {
            orientation = Gtk.Orientation.HORIZONTAL;

            var icon = new Gtk.Image.from_icon_name ("up-down-symbolic", Gtk.IconSize.SMALL_TOOLBAR);

            upload_label = new Gtk.Label ("N/A");
            upload_label.set_width_chars (8);
            var upload_label_context = upload_label.get_style_context ();
            upload_label_context.add_class ("small-label");
            upload_label_context.add_class ("upload");

            download_label = new Gtk.Label ("N/A");
            download_label.set_width_chars (8);
            var down_label_context = download_label.get_style_context ();
            down_label_context.add_class ("small-label");
            down_label_context.add_class ("download");

            var group = new Gtk.Grid ();
            group.add (upload_label);
            group.add (icon);
            group.add (download_label);

            widget_revealer = new Gtk.Revealer ();
            widget_revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_RIGHT;
            widget_revealer.reveal_child = true;

            widget_revealer.add (group);

            add (widget_revealer);
        }

        public void update_label_data (string up_speed, string down_speed) {
            upload_label.label = up_speed;
            download_label.label = down_speed;
        }
    }
}
