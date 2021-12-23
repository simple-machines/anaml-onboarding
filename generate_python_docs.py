import pkgutil

# To run:
# $ PYTHONPATH=anaml-python-sdk/src generate_python_docs.py

# this is the package we are inspecting
import anaml_client

def find_pkgs(package):
    for importer, modname, ispkg in pkgutil.iter_modules(package.__path__, package.__name__ + "."):
        filename = modname.replace("anaml_client.", "").replace(".", "_")
        pagename = modname.replace("anaml_client.", "").replace("models.", "")
        if pagename != "" and pagename != "models":
            print(f"    - {pagename}: 'python_sdk/{filename}.md'")
            with open('docs/python_sdk/' + filename + '.md', 'w') as writer:
                writer.write(f"# {filename}\n")
                writer.write("\n")
                writer.write(f"::: {modname}\n")

        if ispkg:
            module = __import__(modname, fromlist="dummy")
            find_pkgs(module)

find_pkgs(anaml_client)
