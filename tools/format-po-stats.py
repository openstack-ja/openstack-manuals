#!/usr/bin/env python

import sys

columns = ['filename', 'fuzzy', 'untranslated', 'total', 'progress']
title_abbrev = {'untranslated': 'untrans',
                'progress': 'prog%'}
aligns = {'default': 'right',
          'filename': 'left'}

def read_stats():
    stats = []
    for line in sys.stdin.readlines():
        line = line.strip()
        filename, stats_out = line.strip().split(':', 1)
        stats_out = stats_out.strip().replace(', ', ',').rstrip('.')
        page_stat = {'translated': 0, 'fuzzy': 0, 'untranslated': 0}
        for stat in stats_out.split(','):
            num, msgtype, _dummy = stat.split(' ', 2)
            page_stat[msgtype] = int(num)
        page_stat['total'] = sum(page_stat.values())
        page_stat['filename'] = filename
        page_stat['progress'] = page_stat['translated'] / page_stat['total']
        stats.append(page_stat)
    return stats

def calc_summary_stat(stats):
    sum_stat = {}
    for key in ['total', 'translated', 'fuzzy', 'untranslated']:
        sum_stat[key] = sum([stat[key] for stat in stats])
    sum_stat['filename'] = 'Summary'
    sum_stat['progress'] = sum_stat['translated'] / sum_stat['total']
    return sum_stat

def format_stat(stat):
    return [stat['filename'],
            "%d" % stat['fuzzy'],
            "%d" % stat['untranslated'],
            "%d" % stat['total'],
            "%.1f" % stat['progress']]

def print_separator(col_spec):
    line = '+'
    for col in col_spec:
        line += '-' * (col[0] + 2) + '+'
    print line

def print_line(data, col_spec):
    line = '|'
    for i, col in enumerate(col_spec):
        if col[1] == 'right':
            d = data[i].rjust(col[0])
        else:
            d = data[i].ljust(col[0])
        line += ' %s |' % d
    print line

def format_table(title, data, sum_data, align):
    col_spec = []
    for i in xrange(len(title)):
        col_spec.append((max([len(x[i]) for x in [title] + data + sum_data]),
                         align[i]))
    print_separator(col_spec)
    print_line(title, col_spec)
    print_separator(col_spec)
    for d in data:
        print_line(d, col_spec)
    print_separator(col_spec)
    for d in sum_data:
        print_line(d, col_spec)
    print_separator(col_spec)

def main():
    stats = read_stats()
    sum_stat = calc_summary_stat(stats)

    data = [format_stat(stat) for stat in stats]
    sum_data = format_stat(sum_stat)
    title_data = [title_abbrev.get(key, key) for key in columns]

    default_align = aligns.get('default', 'left')
    align_data = [aligns.get(key, default_align) for key in columns]

    format_table(title_data, data, [sum_data], align_data)

if __name__ == '__main__':
    main()
