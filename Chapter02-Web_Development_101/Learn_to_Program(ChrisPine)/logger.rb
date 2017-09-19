$depth = 0
$space = '  ' 

def log description, &block
  puts $space*$depth+'Starting '+description+'...'
  $depth = $depth + 1
  var1 = block.call
  $depth = $depth - 1
  puts $space*$depth+'...'+description+' ending. Return:' +var1
end

log 'globalBlock' do
  
    log 'mediumBlock' do
      log 'smallBlock' do
      	'CHIBI WORLD!!!!'
      end
        'mid-world'
    end
  'SEKAIII'
end