project('com.github.plugarut.wingpanel-monitor', 'vala', 'c')

gnome = import('gnome')
i18n = import('i18n')

add_project_arguments(['--vapidir', join_paths(meson.current_source_dir(), 'vapi')], language: 'vala')
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()), language:'c')

# common dirs
prefix = get_option('prefix')
datadir = join_paths(prefix, get_option('datadir'))
libdir = join_paths(prefix, get_option('libdir'))
icondir = join_paths(datadir, 'icons', 'hicolor')

# deps
wingpanel= dependency('wingpanel-2.0',required : false)
if not wingpanel.found()
    wingpanel = dependency('wingpanel',required : true)
endif

icons_gresource = gnome.compile_resources(
    'gresource_icons',
    'data/icons/icons.indicator.gresource.xml',
    source_dir: 'data/icons',
    c_name: 'as'
)

config_data = configuration_data()
config_data.set_quoted('GETTEXT_PACKAGE', meson.project_name())

configure_file(output: 'config.h', configuration: config_data)
config_h_dir = include_directories('.')


c_args = [
  '-DGWEATHER_I_KNOW_THIS_IS_UNSTABLE',
  '-include', 'config.h',
  '-w',
]

executable(
    meson.project_name(),
    icons_gresource,
    'src/Application.vala',
    'src/MainWindow.vala',
    'src/Widgets/SpinRow.vala',
    'src/Widgets/Toggles.vala',
    c_args: c_args,
    dependencies: [
        dependency('gee-0.8'),
        dependency('glib-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0'),
        dependency('libgtop-2.0'),
        dependency('gweather-3.0'),
        dependency('libgeoclue-2.0'),
        dependency('libhandy-1'),
        wingpanel,
        meson.get_compiler('c').find_library('m', required : false),
        meson.get_compiler('vala').find_library('posix')
    ],
    vala_args: [
        '--vapidir=' + meson.source_root() + '/vapi/',
    ],
    install: true
)



shared_module(
    'wingpanel-monitor',
    'src/Indicator.vala',
    'src/Widgets/DisplayWidget.vala',
    'src/Widgets/PopoverWidget.vala',
    'src/Widgets/IndicatorWidget.vala',
    'src/Widgets/PopoverWidgetRow.vala',
    'src/Widgets/NetworkWidget.vala',
    'src/Services/Cpu.vala',
    'src/Services/Memory.vala',
    'src/Services/Network.vala',
    'src/Services/Utils.vala',
    'src/Services/System.vala',
    icons_gresource,
    c_args: c_args,
    dependencies: [
        dependency('gee-0.8'),
        dependency('glib-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0'),
        dependency('libgtop-2.0'),
        dependency('gdk-x11-3.0'),
        wingpanel,
    ],
    install: true,
    install_dir : wingpanel.get_pkgconfig_variable('indicatorsdir', define_variable: ['libdir', libdir]),
)

subdir('data')
meson.add_install_script('meson/post_install.py')
