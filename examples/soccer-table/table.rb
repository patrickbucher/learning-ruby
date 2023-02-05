#!/usr/bin/env ruby

def parse(line)
  ht, hg, ag, at = line.match(/^(.+) (\d+):(\d+) (.+)$/).captures
  [{t_a: ht, g_a: hg.to_i, t_b: at, g_b: ag.to_i},
   {t_a: at, g_a: ag.to_i, t_b: ht, g_b: hg.to_i}]
end

def accumulate(rows)
  rows.reduce({w: 0, t: 0, l: 0, g_made: 0, g_got: 0, g_diff: 0, p: 0}) { |acc, r|
    acc.merge(r) { |k, l, r| if l.is_a? String then l else l + r end }
  }
end

def to_table_row(r)
  row = {team: r[:t_a], g_made: r[:g_a], g_got: r[:g_b], g_diff: r[:g_a] - r[:g_b]}
  if r[:g_a] > r[:g_b]
    row.merge({w: 1, t: 0, l: 0, p: 3})
  elsif r[:g_a] < r[:g_b]
    row.merge({w: 0, t: 0, l: 1, p: 0})
  else
    row.merge({w: 0, t: 1, l: 0, p: 1})
  end
end

results = []
file = File.open(ARGV[0])
while (line = file.gets)
  results.concat(parse(line))
end

rows = results.map { |r| to_table_row(r) }
by_team = rows.group_by { |r| r[:team] }
table = by_team.map { |team, rows| accumulate(rows) }
sorted = table.sort_by { |row| [row[:p], row[:g_d], row[:w]] }
ranked = sorted.reverse().map.with_index { |r, i| r.merge({r: i + 1}) }

title = sprintf("%3s %30s %3s %3s %3s %3s %3s %3s %3s",
                "#", "Team", "W", "T", "L", "+", "-", "=", "P")
sep = "-" * title.length
puts title
puts sep
ranked.each { |r| printf("%3d %30s %3d %3d %3d %3d %3d %3d %3d\n",
                         r[:r], r[:team], r[:w], r[:t], r[:l],
                         r[:g_made], r[:g_got], r[:g_diff], r[:p]) }
