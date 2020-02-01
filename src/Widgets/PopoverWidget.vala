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
        private PopoverWidgetRow cpu_freq;
        private PopoverWidgetRow uptime;
        private PopoverWidgetRow network_down;
        private PopoverWidgetRow network_up;
        private PopoverWidgetRow ram;
        private PopoverWidgetRow swap;


        public unowned Settings settings { get; construct set; }

        public PopoverWidget (Settings settings) {
            Object (settings: settings);
        }

        construct {
            orientation = Gtk.Orientation.VERTICAL;
            column_spacing = 4;

            cpu_freq = new PopoverWidgetRow ("Frequency", "0", 4);
            uptime = new PopoverWidgetRow ("Uptime", "0", 4);
            network_down = new PopoverWidgetRow ("Network Down", "0", 4);
            network_up = new PopoverWidgetRow ("Network Up", "0", 4);
            ram = new PopoverWidgetRow ("RAM", "0", 4);
            swap = new PopoverWidgetRow ("Swap", "0", 4);

            var settings_button = new Gtk.ModelButton ();
            settings_button.text = _ ("Open Settings…");
            settings_button.clicked.connect (() => {
                try {
                    var appinfo = AppInfo.create_from_commandline (
                        "com.github.plugarut.wingpanel-monitor", null, AppInfoCreateFlags.NONE
                        );
                    appinfo.launch (null, null);
                } catch (Error e) {
                    warning ("%s\n", e.message);
                }
            });

            var hide_button = new Gtk.ModelButton ();
            hide_button.text = _ ("Hide Indicator");
            hide_button.clicked.connect ( () => {
                settings.set_value ("display-indicator", false);
            });

            var title_label = new Gtk.Label ("Wingpanel Monitor");
            title_label.halign = Gtk.Align.CENTER;
            title_label.hexpand = true;
            title_label.margin_start = 9;
            title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);


            add (title_label);
            add (new Wingpanel.Widgets.Separator ());
            add (cpu_freq);
            add (ram);
            add (swap);
            add (uptime);
            add (network_down);
            add (network_up);
            add (new Wingpanel.Widgets.Separator ());
            add (hide_button);
            add (settings_button);
        }

        public void update_cpu_frequency (double val) {
            var formated_value = Utils.format_frequency (val);
            cpu_freq.label_value = formated_value;
        }

        public void update_uptime (string val) {
            uptime.label_value = val;
        }

        public void update_ram (double used_ram, double total_ram) {
            var used = Utils.format_size (used_ram);
            var total = Utils.format_size (total_ram);
            ram.label_value = "%s / %s".printf (used, total);
        }

        public void update_swap (double used_swap, double total_swap) {
            var used = Utils.format_size (used_swap);
            var total = Utils.format_size (total_swap);
            swap.label_value = "%s / %s".printf (used, total);
        }

        public void update_network (int upload, int download) {
            network_down.label_value = Utils.format_net_speed (upload, true, false);
            network_up.label_value = Utils.format_net_speed (download, true, false);
        }
    }
}
