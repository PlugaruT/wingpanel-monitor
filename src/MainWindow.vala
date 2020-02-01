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
    public class MainWindow : Gtk.Window {
        private TogglesWidget toggles;

        public MainWindow (Gtk.Application application) {
            Object (
                application: application,
                border_width: 1,
                icon_name: "com.github.plugarut.wingpanel-monitor",
                resizable: false, title: "Wingpanel Monitor",
                window_position: Gtk.WindowPosition.CENTER
                );
        }

        construct {
            default_width = 300;
            toggles = new TogglesWidget ();

            var layout = new Gtk.Grid ();
            layout.hexpand = true;
            layout.margin = 10;
            layout.column_spacing = 6;
            layout.row_spacing = 10;

            layout.attach (toggles, 0, 1, 1, 1);

            var header = new Gtk.HeaderBar ();
            header.show_close_button = true;

            var header_context = header.get_style_context ();
            header_context.add_class ("titlebar");
            header_context.add_class ("default-decoration");
            header_context.add_class (Gtk.STYLE_CLASS_FLAT);

            set_titlebar (header);
            add (layout);
        }

    }
}
