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
    public class TogglesWidget : Gtk.Grid {
        private Wingpanel.Widgets.Switch cpu_switch;
        private Wingpanel.Widgets.Switch ram_switch;
        private Wingpanel.Widgets.Switch network_switch;
        private Wingpanel.Widgets.Switch label_description_switch;
        private Wingpanel.Widgets.Switch graph_switch;
        private Wingpanel.Widgets.Switch indicator_icon_switch;

        public TogglesWidget () {
            name = "settings";
            orientation = Gtk.Orientation.HORIZONTAL;
            hexpand = true;
        }

        construct {
            cpu_switch = new Wingpanel.Widgets.Switch ("Display CPU usage");
            ram_switch = new Wingpanel.Widgets.Switch ("Display RAM usage");
            network_switch = new Wingpanel.Widgets.Switch ("Display Network usage");
            label_description_switch = new Wingpanel.Widgets.Switch ("Display label");
            graph_switch = new Wingpanel.Widgets.Switch ("Display graph");
            indicator_icon_switch = new Wingpanel.Widgets.Switch ("Display icon");

            attach (cpu_switch,                 0, 1, 1, 1);
            attach (ram_switch,                 0, 2, 1, 1);
            attach (network_switch,             0, 3, 1, 1);
            attach (label_description_switch,   0, 4, 1, 1);
            attach (graph_switch,               0, 5, 1, 1);
            attach (indicator_icon_switch,      0, 6, 1, 1);
        }
    }
}
