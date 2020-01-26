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

        private Wingpanel.Widgets.Switch indicator;

        public static GLib.Settings settings;

        public TogglesWidget () {
            orientation = Gtk.Orientation.HORIZONTAL;
            hexpand = true;
        }

        construct {
            settings = new GLib.Settings ("com.github.plugarut.wingpanel-monitor");

            cpu_switch = new Wingpanel.Widgets.Switch ("Display CPU usage", settings.get_boolean("show-cpu"));
            ram_switch = new Wingpanel.Widgets.Switch ("Display RAM usage", settings.get_boolean("show-ram"));
            network_switch = new Wingpanel.Widgets.Switch ("Display Network usage", settings.get_boolean("show-network"));
            label_description_switch = new Wingpanel.Widgets.Switch ("Display label", settings.get_boolean("show-desr"));
            graph_switch = new Wingpanel.Widgets.Switch ("Display graph", settings.get_boolean("show-graph"));
            indicator_icon_switch = new Wingpanel.Widgets.Switch ("Display Indicator icon", settings.get_boolean("show-icon"));

            indicator = new Wingpanel.Widgets.Switch ("Display Indicator in Wingpanel", settings.get_boolean("display-indicator"));


            settings.bind ("display-indicator", indicator.get_switch (), "active", SettingsBindFlags.DEFAULT);

            settings.bind ("show-cpu", cpu_switch.get_switch (), "active", SettingsBindFlags.DEFAULT);
            settings.bind ("show-ram", ram_switch.get_switch (), "active", SettingsBindFlags.DEFAULT);
            settings.bind ("show-network", network_switch.get_switch (), "active", SettingsBindFlags.DEFAULT);
            settings.bind ("show-desr", label_description_switch.get_switch (), "active", SettingsBindFlags.DEFAULT);
            settings.bind ("show-graph", graph_switch.get_switch (), "active", SettingsBindFlags.DEFAULT);
            settings.bind ("show-icon", indicator_icon_switch.get_switch (), "active", SettingsBindFlags.DEFAULT);

            attach (cpu_switch,                 0, 1, 1, 1);
            attach (ram_switch,                 0, 2, 1, 1);
            attach (network_switch,             0, 3, 1, 1);
            attach (label_description_switch,   0, 4, 1, 1);
            attach (graph_switch,               0, 5, 1, 1);
            attach (indicator_icon_switch,      0, 6, 1, 1);
            attach (indicator,                  0, 7, 1, 1);
        }
    }
}
