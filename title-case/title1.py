def process(data):
  lines = data.split('\n')
  return "\n".join([process_line(line) for line in lines])


def process_line(line):
  words = line.split(' ')
  new = [w.capitalize() for w in words]
  return " ".join(new)

if __name__ == '__main__':
  data = open('input.txt').read()
  print process(data)
