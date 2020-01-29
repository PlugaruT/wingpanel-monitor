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
    public class PopoverWidget : Gtk.Grid {
        construct {
            column_spacing = 4;
            margin_top = 4;

            var settings_button = new Gtk.ModelButton ();
            settings_button.text = _ ("Open Settings");
            settings_button.get_style_context ().add_class ("menuitem");
            settings_button.get_style_context ().remove_class ("button");
            settings_button.clicked.connect (() => {
                try {
                    AppInfo.launch_default_for_uri ("com.github.plugarut.wingpanel-monitor", null);
                } catch (Error e) {
                    warning ("%s\n", e.message);
                }
            });


            var separator_start = new Wingpanel.Widgets.Separator ();
            separator_start.hexpand = true;

            attach (separator_start, 0, 0, 1, 1);
            attach (settings_button,     0, 1, 1, 1);

        }
    }
}

