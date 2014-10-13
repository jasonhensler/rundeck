    <g:jsonToken id="storage_browser_token" url="${request.forwardURI}"/>
    <div class="alert alert-warning" data-bind="visible: errorMsg()">
        <span data-bind="text: errorMsg"></span>
    </div>
    <div class="row text-info form-inline">
        <div class="form-group col-sm-12" data-bind="css: invalid()?'has-error':'' ">
            <div class="input-group">
                <div class="input-group-addon" data-bind="if: staticRoot()">
                    <span data-bind="text: rootPath() + '/'"></span>
                </div>
                <input type="text" class="form-control"
                       data-bind="value: inputPath, valueUpdate: 'input', attr: {disabled: loading() }, executeOnEnter: browseToInputPath"
                       placeholder="Enter a path"/>
            </div>
        </div>
    </div>
    <div class="row row-space">
        <div class="col-sm-12">
    <div >
        <button type="button" class="btn btn-sm btn-default"
                data-bind="click: function(){$root.loadDir(upPath())}, css: {disabled: ( !upPath() || invalid() ) }" >
            <i class="glyphicon glyphicon-folder-open"></i>
            <i class="glyphicon glyphicon-arrow-up"></i>
            <span data-bind="text: upPath() ? $root.dirName(upPath()) : '' "></span>
        </button>

        <div class="btn-group" data-bind="if: browseMode()=='browse'">
            <button type="button" class="btn btn-sm btn-default dropdown-toggle"
                    data-bind="css: { disabled: !selectedPath() }"
                    data-toggle="dropdown">
                Action <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" role="menu">
                <li><a href="#storageconfirmdelete" data-toggle="modal"><i class="glyphicon glyphicon-remove"></i> Delete Selected Item</a></li>

                <li class="" data-bind=" if: selectedIsDownloadable()">
                    <a href="#" data-bind="click: download"><i class="glyphicon glyphicon-download"></i> Download Contents</a>
                </li>
            </ul>
        </div>

        <div class="btn-group" data-bind="if: allowUpload() ">
            <a href="#storageuploadkey" data-bind="click: actionUpload"
               class="btn btn-sm btn-success ">
                <i class="glyphicon glyphicon-plus"></i> Add or Upload a Key</span>
            </a>
        </div>
        <div class="btn-group" data-bind="if: allowUpload() && selectedPath() ">
            <a href="#storageuploadkey" data-bind="click: actionUploadModify"
               class="btn btn-sm btn-info ">
                <i class="glyphicon glyphicon-pencil"></i> Overwrite Key</span>
            </a>
        </div>
    </div>
    <div class="loading-area text-info " data-bind="visible: loading()"
         style="width: 100%; height: 200px; padding: 50px; background-color: #eee;">
        <i class="glyphicon glyphicon-time"></i> Loading...
    </div>
    <table class="table table-hover table-condensed" data-bind="if: !invalid() && !loading()">
        <tbody data-bind="if: !notFound()">
        <tr>
            <td colspan="2" class="text-muted">
                <span data-bind="if: filteredFiles().length < 1">
                    No keys
                </span>
                <span data-bind="if: filteredFiles().length > 0">
                    <span data-bind="text: filteredFiles().length"></span> keys
                </span>
            </td>
        </tr>
        </tbody>
        <tbody data-bind="foreach: filteredFiles()">
        <tr data-bind="click: $root.selectFile, css: $root.selectedPath()==path() ? 'success' : '' " class="action">
            <td >
                <i class="glyphicon "
                   data-bind="css: $root.selectedPath()==path() ? 'glyphicon-ok' : 'glyphicon-unchecked' "></i>

                <span data-bind="if: $data.isPrivateKey()"
                      title="This path contains a private key that can be used for remote node execution.">
                    <i class="glyphicon glyphicon-lock"></i>
                </span>
                <span data-bind="if: $data.isPublicKey()">
                    <i class="glyphicon glyphicon-eye-open"></i>
                </span>
                <span data-bind="if: $data.isPassword()"
                      title="This path contains a password that can be used for remote node execution.">
                    <i class="glyphicon glyphicon-lock"></i>
                </span>

                <span data-bind="text: name"></span>
            </td>
            <td class="text-muted">
                <span class="pull-right">
                <span data-bind="if: $data.isPrivateKey()"
                    title="This path contains a private key that can be used for remote node execution."
                >
                    Private key
                </span>
                <span data-bind="if: $data.isPublicKey()">
                    Public key
                </span>
                <span data-bind="if: $data.isPassword()"
                    title="This path contains a password that can be used for remote node execution.">
                    Password
                </span>
                </span>
            </td>
        </tr>
        </tbody>

        <tbody data-bind="if: notFound()">
        <tr>
            <td colspan="2">
                <span class="text-muted">Nothing found at this path.
                <span data-bind="if: allowUpload()">Select "Add or Upload a Key" if you would like to create a new key.</span>
                </span>
            </td>
        </tr>
        </tbody>
        <tbody data-bind="foreach: directories()">
        <tr>
            <td class="action" data-bind="click: $root.loadDir" colspan="2">
                <i class="glyphicon glyphicon-arrow-down"></i>
                <i class="glyphicon glyphicon-folder-close"></i>
                <span data-bind="text: $root.dirName($data)"></span>
            </td>
        </tr>
        </tbody>

    </table>

        </div>
    </div>
    <div class="row row-space" data-bind="if: selectedPath()">
    <div class="col-sm-12">
        <div class="well">
            <div>
                Storage path:
                <code class="text-success"
                      data-bind="text: selectedPath()"></code>
                <a href="#" data-bind="attr: { href: selectedPathUrl() }"><i class="glyphicon glyphicon-link"></i></a>
            </div>

            <div data-bind="if: selectedResource() && selectedResource().createdTime()"
                class="text-muted">
                <div >
                    Created:
                    <span class="timeabs" data-bind="text: selectedResource().createdTime(), attr: { title:  selectedResource().meta()['Rundeck-content-creation-time'] }"></span>

                    <span data-bind="if: selectedResource().createdUsername()">
                        by:

                        <span data-bind="text: selectedResource().createdUsername()"></span>
                    </span>

                </div>
            </div>
            <div data-bind="if: selectedResource() && selectedResource().wasModified()"
                 class="text-muted">
                <div >
                    Modified:
                    <span class="timeago" data-bind="text: selectedResource().modifiedTimeAgo('ago'), attr: { title:  selectedResource().meta()['Rundeck-content-modify-time'] }"></span>

                    <span data-bind="if: selectedResource().modifiedUsername()">
                        by:

                        <span data-bind="text: selectedResource().modifiedUsername()"></span>
                    </span>
                </div>
            </div>

            %{--todo: view contents--}%
            <div data-bind="if: selectedResource() && selectedResource().isPublicKey()">
                    <button
                            data-bind="click: function(){$root.actionLoadContents('publicKeyContents');}, visible: !selectedResource().wasDownloaded()"
                            class="btn btn-sm btn-default"
                            data-loading-text="Loading…"
                    >
                        View Public Key Contents (<span data-bind="text: selectedResource().contentSize()"></span> bytes)
                    </button>

                <pre id="publicKeyContents"  class="pre-scrollable" data-bind="visible: selectedResource().wasDownloaded()">

                </pre>
            </div>
        </div>


    </div>
    </div>
