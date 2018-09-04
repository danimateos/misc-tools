import nbformat 


def strip_cell(cell):

    cell['source'] = ''
    cell['outputs'] = []

    if iscode(cell):
        cell['execution_count'] = None

    return cell


def iscode(cell):

    return cell['cell_type'] == 'code'


def strip_notebook(notebook, criterion=iscode, process=strip_cell):

    new_cells = [process(cell) if criterion(cell) else cell for cell in notebook['cells']]
    nodups = drop_duplicates(new_cells)

    notebook['cells'] = nodups
    return notebook


def insert_in_path(path, suffix):

    path_elements = path.split('/')
    file_name = path_elements.pop()
    name_elements = file_name.split('.')
    name_elements.insert(-1, suffix)
    path_elements.append('.'.join(name_elements))
    new_path = '/'.join(path_elements)

    return new_path


def drop_duplicates(cells):

    result = []

    result.append(cells[0])

    for cell, previous in zip(cells[1:], cells):
        if cell['cell_type'] == 'code':
            pass
            #print (cell, previous)
        if cell['source'] != previous['source']:
            result.append(cell)

    return result


if __name__ == '__main__':
    import sys

    notebook_path = sys.argv[1]
    new_path = insert_in_path(notebook_path, 'empty')
    latest_version = sorted(nbformat.versions.keys())[-1]
    nb = nbformat.read(notebook_path, latest_version)

    cleared_notebook = strip_notebook(nb)

    nbformat.write(cleared_notebook, new_path)
